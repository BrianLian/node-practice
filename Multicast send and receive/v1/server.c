#include <sys/types.h>
#include <sys/socket.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <netinet/in.h>
#include <arpa/inet.h>
//多播的客戶端程序
#define PORT 6260
#define MCAST "224.0.0.251"

int main(int argc, char*argv[]) {
	int s;
	int ret;
	int on = 1;
	int size;
	int ttl = 255;
	int loop = 1;
	int times = 0;
	char buffer[2048];
	struct sockaddr_in localaddr, fromaddr;
	struct ip_mreqn addr;

	s = socket(AF_INET, SOCK_DGRAM, 0);
	if(s < 0){
		perror("socket error");
		return -1;
	}
	//多播的地址結構
	localaddr.sin_family = AF_INET;
	localaddr.sin_port = htons(PORT);
	localaddr.sin_addr.s_addr = htonl(INADDR_ANY);
	//綁定地址結構到套接字
	ret = setsockopt(s, SOL_SOCKET, SO_REUSEADDR, &on, sizeof(on) );
	if(ret < 0){
			perror("bind1 error");
			return -1;
	}
	ret = bind(s, (struct sockaddr*)&localaddr, sizeof(localaddr));//客戶端需要綁定端口，用來接收服務器的數據，得指定接收端口，因為數據先從服務器發送過來的
	if(ret < 0){
		perror("bind error");
		return -1;
	}
	//設置多播的TTL值
	if(setsockopt(s, IPPROTO_IP, IP_MULTICAST_TTL,	&ttl,sizeof(ttl)) < 0){
		perror("IP_MULTICAST_TTL");
		return -1;
	}

	addr.imr_ifindex = if_nametoindex("eth0");
	//addr.imr_ifindex = if_nametoindex("eth0");
	setsockopt(s, IPPROTO_IP, IP_MULTICAST_IF, &addr, sizeof(addr));
	if(ret < 0){
		perror("IP_MULTICAST_IF error");
		return -1;
	}

	//設置數據是否發送到本地迴環接口
	if(setsockopt(s, IPPROTO_IP, IP_MULTICAST_LOOP,&loop,sizeof(loop))<0){
		perror("IP_MULTICAST_LOOP");
		return -1;
	}
	//客戶端加入多播組
	struct ip_mreq mreq;
	mreq.imr_multiaddr.s_addr = inet_addr(MCAST);
	mreq.imr_interface.s_addr = htonl(INADDR_ANY);
	if(setsockopt(s, IPPROTO_IP, IP_ADD_MEMBERSHIP, &mreq, sizeof(mreq)) < 0){
		perror("IP_ADD_MEMBERSHIP");
		return -1;
	}
	//循環接收多播組的消息
	for(times = 0; times < 20; times++){
		int len = sizeof(fromaddr);
		memset(buffer, 0, sizeof(buffer));
		size = recvfrom(s, buffer, 1024, 0, (struct sockaddr*)&fromaddr, &len);
		if(size < 0){
			perror("recvfrom ");
			return -1;
		}
		printf("times is: %d\n", times);
		printf("receive message: %s\n", buffer);
		printf("Port is: %d\n", fromaddr.sin_port);
		printf("IP is: %s\n", inet_ntoa(fromaddr.sin_addr));
		fflush(stdout);
		size = sendto(s, "OK", 2, 0, (struct sockaddr*)&fromaddr, sizeof(fromaddr));
	}

	//離開多播組
	ret = setsockopt(s, IPPROTO_IP, IP_DROP_MEMBERSHIP, &mreq, sizeof(mreq));
	if(ret < 0){
		perror("IP_DROP_MEMBERSHIP");
		return -1;
	}

	close(s);
	return 0;
}


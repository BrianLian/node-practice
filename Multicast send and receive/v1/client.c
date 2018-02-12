#include <sys/socket.h>
#include <sys/types.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <arpa/inet.h>

//服務器實現向多播組發送數據
#define MCAST_PORT 6260
#define MCAST_ADDR "224.0.0.251"
int main(int argc, char* argv[]){
	int ret;
	int s;
	int size;
	int i;
	struct sockaddr_in Multi_addr;	//多播地址
	struct sockaddr_in client_addr;
	char buffer[1024];

	s = socket(AF_INET, SOCK_DGRAM, 0);//建立數據報套接字
	if(s<0){
		perror("socket error");
		return -1;
	}

	Multi_addr.sin_family = AF_INET;
	Multi_addr.sin_port = htons(MCAST_PORT);	//多播端口
	Multi_addr.sin_addr.s_addr = inet_addr(MCAST_ADDR);	//多播地址

	//向多播組發送數據
	for(i = 0; i < 10; i++){
			memset(buffer, 0, sizeof(buffer));
			sprintf(buffer, "%d", i);
			size = sendto(s, buffer, strlen(buffer), 0, (struct sockaddr*)&Multi_addr, sizeof(Multi_addr));
			if(size < 0) {
				perror("sendto error");
			}
			sleep(2);

			printf("Wait for!\n");
			memset(buffer, 0, sizeof(buffer));
			int len = sizeof(client_addr);
			size = recvfrom(s, buffer, 1024, 0,(struct sockaddr*)&client_addr, &len);
			write(stdout, buffer, size);
			sleep(2);
	}
	close(s);
	return 0;
}

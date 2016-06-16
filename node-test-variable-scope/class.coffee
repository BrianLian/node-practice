class test_class
  var_local = 'var_local_'
  constructor: (@var_inst) ->
    console.log 'inst: ', @var_inst
    console.log 'local: ', var_local
    var_local = var_local + @var_inst
    console.log var_local

module.exports = test_class 

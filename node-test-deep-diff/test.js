// Generated by CoffeeScript 1.7.1
(function() {
  var applyChange, diff, lhs, observableDiff, rhs;

  diff = require('deep-diff');

  observableDiff = require('deep-diff').observableDiff;

  applyChange = require('deep-diff').applyChange;

  lhs = {
    name: 'my object',
    description: 'it\'s an object!',
    details: {
      it: 'has',
      an: 'array',
      "with": ['a', 'few', 'elements']
    }
  };

  rhs = {
    name: 'updated object',
    description: 'it\'s an object!',
    details: {
      it: 'has',
      an: 'array',
      "with": [
        'a', 'few', 'more', 'elements', {
          than: 'before'
        }
      ]
    }
  };

  observableDiff(lhs, rhs, function(d) {
    console.log(d.path.length);
    console.log(d.path.join('.'));
    if (d.path.length !== 1 || d.path.join('.' !== 'name')) {
      return applyChange(lhs, rhs, d);
    }
  });

  console.log('==== after applyChange ====');

  console.log(lhs);

  console.log(rhs);

}).call(this);
diff = require('deep-diff')
observableDiff = require('deep-diff').observableDiff
applyChange = require('deep-diff').applyChange

lhs =
    name: 'my object',
    description: 'it\'s an object!',
    details: {
        it: 'has',
        an: 'array',
        with: ['a', 'few', 'elements']
    }

rhs =
    name: 'updated object',
    description: 'it\'s an object!',
    details: {
        it: 'has',
        an: 'array',
        with: ['a', 'few', 'more', 'elements', { than: 'before' }]
    }


observableDiff lhs, rhs, (d) ->
    console.log d.path.length
    console.log d.path.join '.'
    if d.path.length isnt 1 or d.path.join '.' isnt 'name'
        applyChange lhs, rhs, d

console.log '==== after applyChange ===='
console.log lhs
console.log rhs
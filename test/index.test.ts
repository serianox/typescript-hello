import { hello } from '../lib/index'
import { assert } from 'chai'

suite('Functional', () => {
  suite('#hello()', () => {
    test('should return "Hello world!"', () => {
      assert.equal(hello(), "Hello world!")
    })
  })
})

var router = require( 'koa-router' )()

var songs = [{ name: 'Paint It Black', artist: 'The Rolling Stones', duration: 202, album: { name: 'Aftermath', year: 1966 } },
             { name: '(I Can\'t Get No) Satisfaction', artist: 'The Rolling Stones', duration: 225, album: { name: 'Out of Our Heads', year: 1965 } } ]

router.get( '/', function *(next) {
  this.body = 'root'
})

router.get( '/songs', function *(next) {
  console.log( 'GET /songs' )
  this.body = songs
})

module.exports = router

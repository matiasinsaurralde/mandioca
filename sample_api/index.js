var koa = require( 'koa' ),
    app = koa(),
    router = require( './router' )

app
  .use( router.routes() )
  .use( router.allowedMethods() )

app.listen(3000);

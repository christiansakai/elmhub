require('../node_modules/normalize.css/normalize.css')
require('./main.css')

const Github  = require('./github')
const Elm     = require('./Main.elm')

const root = document.getElementById('root')
const github = new Github()

const app = Elm.Main.embed(root)

// from Helper.elm githubSearch
app.ports.githubSearch.subscribe((query) => {
  github.getSearch(query).repositories({}, (err, repositories) => {
    // to Helper.elm githubResponse
    app.ports.githubResponse.send(repositories)
  })
})

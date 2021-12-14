# Set options here
options(golem.app.prod = FALSE)
#TRUE = production mode, FALSE = development mode

# Detach all loaded packages and clean your environment
golem::detach_all_attached()
# rm(list=ls(all.names = TRUE))

# Document and reload your package
golem::document_and_reload()

# Run the application
shiny.painel.liquidez::run_app(INFO_USER_SHINY=shiny.pkg.base::INICIALIZA_INFO_SHINY(SERVIDOR='BDP01REDEQX.redfactor.com.br'),FLAG_VIS = 1)


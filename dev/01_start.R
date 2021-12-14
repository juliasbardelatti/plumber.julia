
golem::fill_desc(
  pkg_name = "plumber.julia", # The Name of the package containing the App 
  pkg_title = "Teste plumber", # The Title of the package containing the App 
  pkg_description = "Teste plumber", # The Description of the package containing the App 
  author_first_name = "julia", # Your First Name
  author_last_name = "sbardelatti",  # Your Last Name
  author_email = "juliasbardelatti@gmail.com",      # Your Email
  repo_url = NULL # The (optional) URL of the GitHub Repo
)     

usethis::use_git()

golem::set_golem_options()

usethis::use_mit_license( name = "Golem User" )  # You can set another licence here

devtools::document()

usethis::use_package("golem")
usethis::use_package("shiny")
usethis::use_package("shinytest")
usethis::use_package("shinyjs")
usethis::use_package("shiny.pkg.base")
usethis::use_package('magrittr')
usethis::use_package('dplyr')
usethis::use_package('reshape2')
usethis::use_package('DT')
usethis::use_package('htmltools')
usethis::use_package('ggplot2')
usethis::use_package('data.table')
usethis::use_package('shinyWidgets')
usethis::use_package('shinydashboard')
usethis::use_package('plotly')


devtools::check()
devtools::test()

golem::add_js_file( "dataTables.rowsGroup" )

golem::document_and_reload()

options('shiny.port'=3030,shiny.host='0.0.0.0')

shiny.painel.liquidez::run_app(INFO_USER_SHINY=shiny.pkg.base::INICIALIZA_INFO_SHINY_NOVO(SERVIDOR='BPD04REDAWS.redfactor.com.br'))


devtools::build(path = './') 

sudo docker build -t 172.16.36.1:5000/shiny_liquidez ./
  

sudo docker image tag 172.16.36.1:5000/shiny_liquidez 172.16.36.1:5000/shiny_liquidez:1.5
sudo docker image tag 172.16.36.1:5000/shiny_liquidez 172.16.36.1:5000/shiny_liquidez:latest


sudo docker push 172.16.36.1:5000/shiny_liquidez:latest
sudo docker push 172.16.36.1:5000/shiny_liquidez:1.4

sudo docker build -t shiny_liquidez ./
  
sudo docker run --env SHINYPROXY_USERNAME=rafael.polli --env SHINYPROXY_USERGROUPS=SHINYADMINISTRADORES -p 5432:3838 172.16.36.1:5000/shiny_liquidez

sudo docker run -i -t -p 7845:3838 172.16.36.1:5000/shiny_liquidez  /bin/bash

docker images



shiny.pkg.base::INICIALIZA_INFO_SHINY_NOVO(SERVIDOR='BDP01REDEQX.redfactor.com.br')

library(xml2)
library(purrr)

genesisws_rest <- "https://www-genesis.destatis.de/genesisWS/rest/2020/application.wadl" |>
  read_xml() |>
  as_list() |>
  pluck("application", "resources") %>%
  # Names of method families:
  set_names(map_chr(., attr, "path")) |>
  # Names of methods:
  map(\(x) set_names(x, map_chr(x, attr, "path"))) |>
  # GET:
  map(\(x) map(x, \(y) set_names(y, map_chr(y, attr, which = "name"))))

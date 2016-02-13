## dairy: Let R Remember the Milk

This is a simple still very experimental wrapper for Remember the Milk's API.

### Installation
```R
devtools::install_github("smbache/dairy")
```

### Authenticate the package with your account:
```R
library(dairy)
authenticate_dairy() 
```

### Usage
So far, there's (almost) only a low-level query function for interacting
with the API:
```R
task_list <- quairy("rtm.tasks.getList")

timeline <- get_timeline()
new_task <- quairy("rtm.tasks.add",
                    name = "Use dairy package", timeline = timeline)
```

## dairy: Let R Remember the Milk

This is a small experimental wrapper for Remember the Milk's API.
The package is meant to provide a low-level interface to the API, rather
than to export a large amount of high level functions to deal with the
(combinations of) API methods. The low-level approach is still relatively easy
to work with, so writing functions for the particular purposes is not
too cumbersome.

### Installation
```R
devtools::install_github("smbache/dairy")
```

### Authenticate the package with your account:
The authentication process need only to be done once per installation, 
or when the token expires. The token is stored in the package installation 
folder and there is no need to store this for a particular project, or 
refer to the home folder, etc. Re-installation, therefore, requires 
re-authentication.
```R
library(dairy)
authenticate_dairy() 
```

### Usage
The main function is `quairy` (a word mix of "query" and "dairy").
Here's an example which receives the task lists:
```R
task_list <- quairy("tasks.getList")
```
Note that while the API methods are named `"rtm.foo.bar"`, it is
possible to omit the `"rtm."` part (it will be appended if missing.).
The API method called above is actually `"rtm.tasks.getList"`.

Many API methods require a "timeline" (which allows certain operations to be
undone). Therefore, there is a function to get a timeline, which will be
created on first call and then cached. Subsequent calls will reuse the last
timeline (unless a new is specifically requested). Here's an example which 
creates a new task:
```R
timeline <- get_timeline()
new_task <- quairy("tasks.add",
                    name = "Use dairy package", timeline = timeline)
```

More generally, `quairy` requires the first argument to be the name of the 
API method, and then accepts an arbitrary amount of named arguments which 
is passed to this API method (such as `name` and `timeline` in the above.)
In addition, it's possible to specify `.auth` which allows deactivation of
authenticaion (which some API methods do not require, although most do) and
`.json` which allows the return value to be the pure json result, instead
of an R list (with class `quairy_result`).

Finally, there are a few convenience functions:

* `quairy_status` which checks whether the API query was successful 
  (if the request itself failed, e.g. no connection, an error is raised in 
  `quairy`).
* more?




#include <stdlib.h>
#include <unistd.h>
#include <emacs-module.h>

int plugin_is_GPL_compatible;

static emacs_value
chdir_run(emacs_env *env, ptrdiff_t nargs, emacs_value args[], void *data)
{
    ptrdiff_t size = 0;
    char *ret, *path;

    env->copy_string_contents(env, args[0], NULL, &size);
    path = malloc(size);
    env->copy_string_contents(env, args[0], path, &size);

    if (chdir(path) == 0)
        ret = "t";
    else
        ret = "nil";

    free(path);
    return env->intern(env, ret);
}

int
emacs_module_init(struct emacs_runtime *ert)
{
    emacs_env *env = ert->get_environment(ert);

    env->funcall(env, env->intern(env, "fset"), 2, (emacs_value[]) { env->intern(env, "chdir--native-run"), env->make_function(env, 1, 1, chdir_run, NULL, NULL) });
    env->funcall(env, env->intern (env, "provide"), 1, (emacs_value[]) { env->intern(env, "chdir-core") });
    return 0;
}

try:
    from rich import print, pretty, inspect, traceback  # noqa: F401
    pretty.install()
    _ = traceback.install(show_locals=True)
    print("[bold green]Rich enabled :tada:")
except ImportError:
    pass

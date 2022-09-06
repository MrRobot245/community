"""
Applet: Next MCU
Summary: Shows the next MCU movie
Description: Countdown untill the next MCU movie, with days and a poster.
Author: mrrobot245
"""

load("encoding/json.star", "json")
load("render.star", "render")
load("schema.star", "schema")
load("math.star", "math")
load("time.star", "time")
load("re.star", "re")
load("http.star", "http")
load("encoding/base64.star", "base64")
load("cache.star", "cache")

def capanim(input):
    return max(0, min(100, input))

def main(config):
    children = []
    rep_cache = cache.get("mcu")
    if rep_cache != None:
        print("Hit! Displaying cached data.")
        rep = json.decode(rep_cache)
    else:
        print("Miss! Calling MCU API.")
        rep = http.get("https://www.whenisthenextmcufilm.com/api")
        
        if rep.status_code != 200:
            fail("MCU request failed with status:", rep.status_code)
        rep = rep.json()
        cache.set("mcu", json.encode(rep), ttl_seconds = 3600)

        print(rep["days_until"])
        print(rep["title"])
        # print(rep["poster_url"])
        print(rep["release_date"])
        print(rep["overview"])
        # res = http.get(url)
    # if res.status_code != 200:
        # fail("status %d from %s: %s" % (res.status_code, url, res.body()))

    state = {
        "days_until": str(int(rep["days_until"])),
        "title":rep["title"],
        "poster_url":http.get(rep["poster_url"]).body(),
        "release_date":rep["release_date"],
        "overview":rep["overview"],
    }

    children.append(
        render.Row(
            expanded = True,
            main_align = "center",
            children = [
                render.Text("UL: "),
                render.Box(width = 2, height = 1),
                # render.Text("%s" % state["bandwidth"], font = "", color = lightness("#e5a00d", animprogress / 100)),
            ],
        )
    )
    return render.Root(
        # delay = 32,  # 30 fps
        child = render.Box(
            child = render.Animation(
                children = [
                    get_frame(state, fr, config, capanim((fr) * 4))
                    for fr in range(300)
                ],
            ),
        ),
    )
def get_frame(state, fr, config,animprogress):
    children = []
    delay = 0
    # print(state["poster_url"])

    children.append(
        render.Row(
            expanded = True,
            main_align = "space_around",
            cross_align = "center",
            children = [
                render.Marquee(
                    width=60,
                    child=render.Text(state["title"]),
                    # offset_start=5,
                    # offset_end=32,
                )
                # render.Text(str(state["days_until"])),
                
                # render.Text("Streams:"),
                # render.Box(width = 1, height = 1),
                # render.Text("%s" % state["users"], font = "", color = lightness("#e5a00d", animprogress / 100)),
            ],
        ),
    )  
    children.append(
        render.Row(
            expanded = True,
            main_align = "space_around",
            cross_align = "center",
            children = [
                render.Text("Days Left: %s" % state["days_until"]),
                # render.Text(str(state["days_until"])),
                
                # render.Text("Streams:"),
                # render.Box(width = 1, height = 1),
                # render.Text("%s" % state["users"], font = "", color = lightness("#e5a00d", animprogress / 100)),
            ],
        ),
    )
    children.append(
        render.Row(
            expanded = True,
            main_align = "space_around",
            cross_align = "center",
            children = [
                render.Marquee(
                    # width=60,
                    child=render.Text(state["overview"]),
                    scroll_direction="vertical",
                    # offset_start=5,
                    # offset_end=32,
                    height=15,
                )
                # render.Text(str(state["days_until"])),
                
                # render.Text("Streams:"),
                # render.Box(width = 1, height = 1),
                # render.Text("%s" % state["users"], font = "", color = lightness("#e5a00d", animprogress / 100)),
            ],
        ),
    )  

    # children.append(
    #     render.Row(
    #         expanded = True,
    #         main_align = "space_around",
    #         cross_align = "center",
    #         children = [
    #             render.Image(
    #             src = state["poster_url"],
    #             # width = 65,
    #             height = 15,
    #              ),
    #             # render.Text("Streams:"),
    #             # render.Box(width = 1, height = 1),
    #             # render.Text("%s" % state["users"], font = "", color = lightness("#e5a00d", animprogress / 100)),
    #         ],
    #     ),
    # )


    return render.Column(
        main_align = "space_between",
        cross_align = "center",
        children = children,
    )


def get_schema():
    return schema.Schema(
        version = "1",
        fields = [],
    )
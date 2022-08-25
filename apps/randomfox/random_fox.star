"""
Applet: Random Fox
Summary: Picture of random foxes
Description: Gets pictures of random foxes.
Author: mrrobot245
"""


load("encoding/json.star", "json")
load("render.star", "render")
load("schema.star", "schema")
load("http.star", "http")



def main(config):

    rep = http.get("https://randomfox.ca/floof/")
    imgSrc = http.get(rep.json()["image"]).body()


    imgSrc = http.get("https://cataas.com/cat/gif").body()


    children = []
    children.append(
        render.Row(
            expanded = True,
            main_align = "center",
            children = [
                render.Image(
                    src = imgSrc,
                    # width = 65,
                    height = 35,
            ),
            ],
        ),
    )
    return render.Root(
        delay = 32,  # 30 fps
        child = render.Column(
                main_align = "space_between",
                cross_align = "center",
                children = children,
            )
    )

def get_schema():
    return schema.Schema(
        version = "1",
        fields = [],
    )
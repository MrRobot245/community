// Package randomfox provides details for the Random Fox applet.
package randomfox

import (
	_ "embed"

	"tidbyt.dev/community/apps/manifest"
)

//go:embed random_fox.star
var source []byte

// New creates a new instance of the Random Fox applet.
func New() manifest.Manifest {
	return manifest.Manifest{
		ID:          "random-fox",
		Name:        "Random Fox",
		Author:      "mrrobot245",
		Summary:     "Picture of random foxes",
		Desc:        "Gets pictures of random foxes.",
		FileName:    "random_fox.star",
		PackageName: "randomfox",
		Source:  source,
	}
}

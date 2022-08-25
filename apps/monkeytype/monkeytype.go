// Package monkeytype provides details for the Monkeytype applet.
package monkeytype

import (
	_ "embed"

	"tidbyt.dev/community/apps/manifest"
)

//go:embed monkeytype.star
var source []byte

// New creates a new instance of the Monkeytype applet.
func New() manifest.Manifest {
	return manifest.Manifest{
		ID:          "monkeytype",
		Name:        "Monkeytype",
		Author:      "mrrobot245",
		Summary:     "Display typing stats",
		Desc:        "Display best typing stats from Monkeytype.",
		FileName:    "monkeytype.star",
		PackageName: "monkeytype",
		Source:  source,
	}
}

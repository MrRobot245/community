// Package nextmcu provides details for the Next MCU applet.
package nextmcu

import (
	_ "embed"

	"tidbyt.dev/community/apps/manifest"
)

//go:embed next_mcu.star
var source []byte

// New creates a new instance of the Next MCU applet.
func New() manifest.Manifest {
	return manifest.Manifest{
		ID:          "next-mcu",
		Name:        "Next MCU",
		Author:      "mrrobot245",
		Summary:     "Shows the next MCU movie",
		Desc:        "Countdown untill the next MCU movie, with days and a poster.",
		FileName:    "next_mcu.star",
		PackageName: "nextmcu",
		Source:  source,
	}
}

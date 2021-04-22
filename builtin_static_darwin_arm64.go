//go:build !external_libs

package grocksdb

// #cgo CFLAGS: -I${SRCDIR}/dist/darwin_arm64/include
// #cgo CXXFLAGS: -I${SRCDIR}/dist/darwin_arm64/include
// #cgo LDFLAGS: -L${SRCDIR}/dist/darwin_arm64/lib -lrocksdb -pthread -lstdc++ -lm
import "C"

//go:build !external_libs

package grocksdb

// #cgo CFLAGS: -I${SRCDIR}/dist/windows_amd64/include
// #cgo CXXFLAGS: -I${SRCDIR}/dist/windows_amd64/include
// #cgo LDFLAGS: -L${SRCDIR}/dist/windows_amd64/lib -L${SRCDIR}/dist/windows_amd64/lib64 -lrocksdb -pthread -lstdc++ -lm
import "C"

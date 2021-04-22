// +build builtin_static !static

package grocksdb

// #cgo CFLAGS: -I${SRCDIR}/dist/linux_arm64/include
// #cgo CXXFLAGS: -I${SRCDIR}/dist/linux_arm64/include
// #cgo LDFLAGS: -L${SRCDIR}/dist/linux_arm64/lib -L${SRCDIR}/dist/linux_arm64/lib64 -lrocksdb -pthread -lstdc++ -lm
import "C"

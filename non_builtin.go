//go:build external_libs

package grocksdb

// #cgo LDFLAGS: -lrocksdb -pthread -lstdc++ -ldl -lm -lzstd -llz4 -lz -lsnappy
import "C"

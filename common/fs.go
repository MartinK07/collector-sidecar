package common

import (
	"os"
	"path"
	"path/filepath"
)

func FileExists(filePath string) error {
	_, err := os.Stat(filePath)
	if os.IsNotExist(err) {
		return err
	}
	return nil

}

func IsDir(filePath string) bool {
	fi, err := os.Stat(filePath)
	if err != nil {
		log.Error(err)
		return false
	}
	if fi.Mode().IsDir() {
		return true
	}
	return false

}

func CreatePathToFile(filepath string) error {
	dir := path.Dir(filepath)
	_, err := os.Open(dir)
	if err != nil {
		log.Info("Trying to create directory for: ", filepath)
		err = os.MkdirAll(dir, 0750)
		if err != nil {
			log.Error("Not able to create directory path: ", dir)
			return err
		}
	}
	return nil
}

func ListFiles(paths []string) []File {
	list := []File{}

	filter := func(path string, file os.FileInfo, err error) error {
		if err == nil {
			list = append(list,
				File{Path: path,
					ModTime: file.ModTime(),
					Size:    file.Size(),
					IsDir:   file.IsDir()})
		}
		return err
	}

	for _, path := range paths {
		if !IsDir(path) {
			continue
		}

		err := filepath.Walk(path, filter)
		if err != nil {
			log.Errorf("Can not get file list for %s", path)
		}
	}

	return list
}
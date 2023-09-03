package storage

import "module30/task"

type Stor interface {
	GetTasks() ([]task.Tasks, error)
	GetTaskId(id int) ([]task.Tasks, error)
	GetTaskLabel(labelId int) ([]task.Tasks, error)
	CreateTask(t []task.Tasks)
	UpdateTask(id int)
	DeleteTask(id int)
}

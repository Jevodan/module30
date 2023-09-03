package main

import (
	"fmt"
	"math/rand"
	"module30/storage"
	"module30/task"
	"time"
)

const (
	COUNT_OF_TASKS = 3    //Количество добавляемых задач
	START_OPEN     = "11" // начало выполнения новых задач
	CLOSE_OPEN     = "16"
)

func main() {
	var db storage.Stor
	db = storage.InitDb()
	tasksList := createTaskList()

	fmt.Println("Получение всех задач")
	tasks, err := db.GetTasks()
	check(err)
	print(tasks)

	fmt.Println("Получение задач конкретного автора")
	tasks2, err := db.GetTaskId(3)
	check(err)
	print(tasks2)

	fmt.Println("Получение задач по метке")
	tasks3, err := db.GetTaskLabel(2)
	check(err)
	print(tasks3)

	fmt.Println("Создание списка задач")
	db.CreateTask(tasksList)

	db.UpdateTask(7)
	db.DeleteTask(8)

}

func print(tasks []task.Tasks) {
	for _, val := range tasks {
		fmt.Printf("%s %s %s %s %s %s %s\n", *val.Open(), *val.Close(), *val.AuthorName(), *val.AssignedName(), *val.Title(), *val.Content(), *val.Label())
	}
}

func check(err error) {
	if err != nil {
		fmt.Println(err)
	}
}

func createTaskList() []task.Tasks {
	var tasksList [COUNT_OF_TASKS]task.Tasks
	rand.Seed(time.Now().UTC().UnixNano())
	for index := range tasksList {
		author := rand.Intn(3) + 1
		assigned := rand.Intn(3) + 1
		tasksList[index] = task.NewTask(START_OPEN+":00:00", CLOSE_OPEN+":00:00", author, assigned, "future task", "soon")
	}
	return tasksList[:]
}

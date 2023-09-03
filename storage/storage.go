package storage

import (
	"database/sql"
	"fmt"
	"log"
	"module30/task"

	_ "github.com/go-sql-driver/mysql"
)

//var storage *Stor

type Storage struct {
	db *sql.DB
}

func InitDb() Stor {
	db, err := sql.Open("mysql", "root:serpent@/tasks")
	if err != nil {
		fmt.Println("Ошибка:", err)
	} else {
		fmt.Println("Есть контакт")
	}
	storage := Storage{
		db: db,
	}
	return &storage
}

// Получение списка задач
func (s *Storage) GetTasks() ([]task.Tasks, error) {

	res, err := s.db.Query("SELECT t.opened," +
		"t.closed," +
		"u1.name as author," +
		"u2.name as assigned," +
		"t.title," +
		"t.content " +
		"FROM tasks as t " +
		"LEFT JOIN users as u1 ON t.author_id=u1.id " +
		"LEFT JOIN users as u2 ON t.assigned_id=u2.id")
	check(err)

	var tasks []task.Tasks
	for res.Next() {
		var t task.Tasks
		err := res.Scan(t.Open(), t.Close(), t.AuthorName(), t.AssignedName(), t.Title(), t.Content())
		checkReturn(tasks, err)
		tasks = append(tasks, t)
	}
	return tasks, nil
}

// Получение списка задач по автору
func (s *Storage) GetTaskId(author int) ([]task.Tasks, error) {

	res, err := s.db.Query("SELECT t.opened,"+
		"t.closed,"+
		"u1.name as author,"+
		"u2.name as assigned,"+
		"t.title,"+
		"t.content "+
		"FROM tasks as t "+
		"LEFT JOIN users as u1 ON t.author_id=u1.id "+
		"LEFT JOIN users as u2 ON t.assigned_id=u2.id where t.author_id= ?", author)
	check(err)
	var tasks []task.Tasks
	for res.Next() {
		var t task.Tasks
		err := res.Scan(t.Open(), t.Close(), t.AuthorName(), t.AssignedName(), t.Title(), t.Content())
		checkReturn(tasks, err)
		tasks = append(tasks, t)
	}
	return tasks, nil
}

// Создание новой задачи
func (s *Storage) CreateTask(t []task.Tasks) {
	tx, err := s.db.Begin()
	check(err)
	stmt, err := s.db.Prepare("INSERT INTO `tasks` " +
		"(id, opened, closed, author_id, assigned_id, title, content) " +
		"VALUES " +
		"(NULL, ?, ?, ?, ?, ?, ?);")
	if err != nil {
		tx.Rollback()
		log.Fatal(err)
	}
	for _, val := range t {
		_, err = stmt.Exec(val.Open(), val.Close(), val.Author(), val.Assigned(), val.Title(), val.Content())
		check(err)
	}
	err = tx.Commit()
	check(err)
}

// Получение списка задач по метке
func (s *Storage) GetTaskLabel(label int) ([]task.Tasks, error) {
	res, err := s.db.Query("SELECT opened, closed,u1.name as author, u2.name as assigned,title,content, l.name FROM tasks.tasks as t "+
		"LEFT JOIN users as u1 ON t.author_id=u1.id "+
		"LEFT JOIN users as u2 ON t.assigned_id=u2.id "+
		"LEFT JOIN tasks_labels as tl ON t.id=tl.tasks_id "+
		"LEFT JOIN labels as l ON tl.label_id=l.id where l.id= ?", label)
	check(err)
	var tasks []task.Tasks
	for res.Next() {
		var t task.Tasks
		err := res.Scan(t.Open(), t.Close(), t.AuthorName(), t.AssignedName(), t.Title(), t.Content(), t.Label())
		checkReturn(tasks, err)
		tasks = append(tasks, t)
	}

	return tasks, nil
}

// Обновление задачи по id (изменение названия)
func (s *Storage) UpdateTask(id int) {
	_, err := s.db.Exec("UPDATE tasks SET title = ? WHERE id=?", "CHANGE TITLE", id)
	check(err)
	fmt.Println("Данные", id, "успешно обновлены.")
}

// Удаление задачи по id
func (s *Storage) DeleteTask(id int) {
	_, err := s.db.Exec("DELETE FROM tasks WHERE id=?", id)
	check(err)
	fmt.Println("Данные", id, "успешно обновлены.")
}

func check(err error) {
	if err != nil {
		log.Fatal(err)
	}
}

func checkReturn(t []task.Tasks, err error) ([]task.Tasks, error) {
	if err != nil {
		log.Fatal(err)
		return nil, err
	}
	return t, nil
}

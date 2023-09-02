package task

var task Tasks

type Tasks struct {
	//id      int
	open         string
	close        string
	author       int
	ass          int
	title        string
	content      string
	authorName   string
	assignedName string
	label        string
}

func NewTask(open string, close string, author int, assigned int, title string, content string) Tasks {
	task.open = open
	task.close = close
	task.author = author
	task.ass = assigned
	task.title = title
	task.content = content
	return task
}

func (t *Tasks) Open() *string {
	return &t.open
}

func (t *Tasks) Close() *string {
	return &t.close
}

func (t *Tasks) Title() *string {
	return &t.title
}

func (t *Tasks) Content() *string {
	return &t.content
}

func (t *Tasks) AuthorName() *string {
	return &t.authorName
}

func (t *Tasks) AssignedName() *string {
	return &t.assignedName
}

func (t *Tasks) Author() *int {
	return &t.author
}

func (t *Tasks) Assigned() *int {
	return &t.ass
}

func (t *Tasks) Label() *string {
	return &t.label
}

package journal
//Extension test double name func
type Extension struct{

}
//Print print journal file path
func (j*Journal)Print()string{
	return j.path
}
//Print print test extension func
func (e *Extension)Print()string{
	return "extension"
}
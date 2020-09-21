extends Control

export var server_ip = "192.168.1.250"
export var data_path = "/home/user1/data1/art/"
export var sync_cmd = "pscp -P 22 -r user1@192.168.1.250:/home/user1/data1/art/ ./Nix/art/"

var path = ""
var thumb_path = ""
var md5 = ""

func _ready():
	var dir = Directory.new()
	dir.make_dir("/Nix/art")
	$Output.clear()

func _on_Upload_pressed():
	
	CopyFileToServer(path,$PanelContainer/VBoxContainer/HBoxContainer3/ID.text)

func _on_FileDialog_file_selected(_path):
	path = _path
	$PanelContainer/VBoxContainer/HBoxContainer/filePath.text = path
	md5 = GetMD5(path)
	$PanelContainer/VBoxContainer/HBoxContainer2/MD5.text = md5
	print("md5:",md5)

func CopyFileToServer(from,id):
	var output = []
	OS.execute("D:/PuTTY/pscp", ["-P","22","-pw","user123456",
	from,"user1@%s:%s%s"%[server_ip,data_path,id+".asc"]], true, output)
	var msg = "Upload %s to [%s] md5:%s"%[from,id,md5]
	$Output.add_text(msg)
	$Output.newline()
	print(output)
	OS.execute("D:/PuTTY/pscp", ["-P","22","-pw","user123456",
	thumb_path,"user1@%s:%s%s"%[server_ip,data_path,id+".jpg"]], true, output)
	print(output)

func _on_file_pressed():
	$FileDialog.popup_centered()

func _on_thumb_pressed():
	$ThumbDlg.Open()

func _on_ThumbDlg_select_file(path):
	thumb_path = path
	var img = Image.new()
	img.load(path)
	var tx = ImageTexture.new()
	tx.create_from_image(img)
	$PanelContainer/VBoxContainer/TextureRect.texture = tx

func _on_Download_pressed():
	OS.execute("D:/PuTTY/pscp",["-P","22","-r","-pw","user123456","user1@%s:%s"%[server_ip,data_path],"/Nix/art/"])

func GetMD5(path):
	var file = File.new()
	return file.get_md5(path)

const CHUNK_SIZE = 1024

func hash_file(path):
	var ctx = HashingContext.new()
	var file = File.new()
	# Start a SHA-256 context.
	ctx.start(HashingContext.HASH_SHA256)
	# Check that file exists.
	if not file.file_exists(path):
		print("file not exists!!!")
		return
	# Open the file to hash.
	file.open(path, File.READ)
	# Update the context after reading each chunk.
	while not file.eof_reached():
		ctx.update(file.get_buffer(CHUNK_SIZE))
	# Get the computed hash.
	var res = ctx.finish()
	# Print the result as hex string and array.
	printt(res.hex_encode(), Array(res))


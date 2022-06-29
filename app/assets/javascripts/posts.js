const editImagesUpload = (num) =>{
  $(".files-button-edit-"+num)[0].click();
}
const getFilesEdit = (num)=>{
  var ele=$(".files-button-edit-"+num)[0];
  var fileList = ele.files;
  if(fileList.length>10)
  {
    alert("Please Upload 10 images or less.");
    ele.value = '';
    return;
  }
  for (let i=0; i<fileList.length; i++)
  {
    if(!(fileList[i].name.includes(".jpg") || fileList[i].name.includes(".png") ||
    fileList[i].name.includes(".jpeg")))
    {
      alert("Please Upload images only");
      ele.value = '';
      location.reload();
      return;
    }
  }
  var el = $(".post-images-"+num)[0];
  el.innerHTML=''
  function readAndPreview(file) {
      var reader = new FileReader();

      reader.addEventListener("load", function () {
        var image = new Image();
        image.height = 100;
        image.title = file.name;
        image.src = this.result;
        image.classList.add("input-files")
        el.appendChild( image );
      }, false);

      reader.readAsDataURL(file);

  }
  if (fileList.length) {
    [].forEach.call(fileList, readAndPreview);
  }
}

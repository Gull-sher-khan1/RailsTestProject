// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
function show_post_comments(num)
{
  let div=[];
  div.push(document.getElementsByClassName("home-page-content-comments-div")[num]);
  div.push(document.getElementsByClassName("home-page-content-post-button")[num]);
  if (div[0].classList.contains("display-none"))
  {
    div[0].classList.remove("display-none");
    div[1].classList.remove("home-page-content-post-button-border-removed");
  }
  else
  {
    div[0].classList.add("display-none");
    div[1].classList.add("home-page-content-post-button-border-removed");
  }
}
function getFiles()
{
  var ele=document.getElementsByClassName("files-button")[0];
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
  var el = document.getElementsByClassName("index-images")[0];
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


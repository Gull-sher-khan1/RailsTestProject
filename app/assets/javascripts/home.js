// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$('.edit_post_text').on('submit',(function(e) {
  var formData = new FormData(this);

  formData.append('_method', 'patch');
  $.ajax({
    type: "POST",
    data: formData,
    cache: false,
    contentType: false,
    processData: false
  }).done(function(r) {
  console.log(r);
});
}));

function showPostComments(num){
  let div=[];
  div.push($(".home-page-content-comments-div")[num]);
  div.push($(".home-page-content-post-button")[num]);
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
function getFiles(){
  var ele=$(".files-button")[0];
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
  var el = $(".index-images")[0];
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

function storyUpload(){
  $(".story-files-button")[0].click();
}

function storyFormSubmit(){
  $("#story_form_submit").submit();
}
function closeWindow(){
  $(".story-show-container")[0].classList.add("display-none");
  $(".body")[0].classList.remove("overflow-hidden");
}
function removeContent(){
 let ele =  $(".found-users")[0];
 if (ele.innerHTML)
 {
   ele.innerHTML="";
 }
 ele = $(".gear-options-container")[0]
 if (!ele.classList.contains("check"))
 {
   ele.classList.add("check")
 }
 else
 {
   ele.classList.remove("check")
   ele.classList.add("display-none")
 }
}
function submitSearch(){
  $(".submit_search")[0].click();
}
function showOptions(){
  $(".gear-options-container")[0].classList.remove("display-none");
}
function bodyoverflow(){
  $(".body")[0].classList.add("overflow-hidden");
}
function bodyoverflowRemoved(){
  $(".body")[0].classList.remove("overflow-hidden");
}
function flashDisappear(ele){
  ele.classList.remove("flash");
  ele.classList.add("display-none");
}

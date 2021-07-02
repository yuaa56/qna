// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "cocoon-js"
import { createConsumer } from "@rails/actioncable"
// export default createConsumer()

Rails.start()
Turbolinks.start()
ActiveStorage.start()

//= requery jquery3

//= requery rails-ujs

//= require jquery.remotipart
//= require jquery.iframe-transport
//= require cocoon

//= requery popper
//= requery bootstrap
// require skim

// app/javascript/channels/cable.js
//= require action_cable
//= require_self
//= require_tree ./channels



document.addEventListener("turbolinks:load", function() {
  var App = App || {};
  App.cable = createConsumer();
  //App.cable = ActionCable.createConsumer();
  //App.cable = createConsumer("ws://localhost:3000/cable");

  /*
  console.log(App);
  console.log(App.cable);
  console.log(App.cable.subscriptions.create('QuestionsChannel'));
  */

  ///*
  App.cable.subscriptions.create('QuestionsChannel',{
    connected: function() {
      // console.log('connected');
      // this.perform('do_something', { text: 'hello!!!' });
      // this.perform('echo', { text: 'hello' });
      this.perform('follow');

    }

    ,

    received: function(data) {
      // console.log('received', data);
      var qTable = document.querySelector(".questions_table");
      var last_row =  document.createElement('tr');
  
  
      // var newQuestion = document.querySelector('.newQuestionLink');
      // newQuestion.onclick = function(e) {
      //      e.preventDefault();
      //    }
     

      last_row.innerHTML = data;
      qTable.appendChild(last_row);

    } 

  });

  App.cable.subscriptions.create('AnswersChannel',{
    connected: function() {
      // console.log('connected');
      // this.perform('do_something', { text: 'hello!!!' });
      // this.perform('echo', { text: 'hello' });
      this.perform('follow');
  
    }

    ,

    received: function(data) {
      // console.log('received', data);
      var aTable = document.querySelector(".answers_table");
      var last_row =  document.createElement('tr');
      
      // var newQuestion = document.querySelector('.newQuestionLink');
      // newQuestion.onclick = function(e) {
      //      e.preventDefault();
      //    }
      
      last_row.innerHTML = data;
      aTable.appendChild(last_row);
      var form_answer = document.querySelector(".new_answer");
      form_answer.style.display = 'none';

    } 

  });

  //*/


  var newComment = document.querySelector('.new_comment')
      if (newComment) {
        newComment.onclick = function() {
          document.querySelector('.comment_container').style.display = 'block';
        } };
  
  /*
   var comment_id = this.dataset.commentId;
   var editComment = document.querySelector('#comment_edit' + comment_id)
      if (editComment) {
        newComment.onclick = function() {
        document.getElementById('edit-comment-' + comment_id).style.display = 'block';

  //        document.querySelector('.comment_edit').style.display = 'block';
        } };
  */
          //console.log(answer_id);

  var blockEdComment = document.querySelectorAll('.edit-comment-link');
  var comment_id = 0;
  blockEdComment.forEach(element => {
    comment_id = element.dataset.commentId;
    document.querySelector('#edit-comment-' + comment_id).style.display = 'none';
    element.addEventListener("click", function (event) {
       document.querySelector('#edit-comment-' + comment_id).style.display = 'block';
      });
  }); 

//  const [_data, _status, xhr] = event.detail;
        
  /*
  var blockDelComment = document.querySelectorAll('.del-comment-link');
  blockDelComment.forEach(element => {
    element.addEventListener("click", function (event) {
      console.log(element.id);
    });
  }); 
  */

   var aaa = document.querySelector('.aaa')
      if (aaa) {
        aaa.onclick = function() {
          document.querySelector('.answers_container').style.display = 'block';

  var form_answer = document.querySelector(".new_answer");
  if (form_answer)  {
    form_answer.addEventListener("ajax:success", (event) => {
      const [_data,] = event.detail;
      var tabl = document.querySelector('.answers_table');

      /* var last_row = document.createElement('tr'); */

      var taskTemplate = document.querySelector('#task-template').content;
      var newItemTemplate = taskTemplate.querySelector('.answer_row_temp');
      
      var newClass = "answer_row_"+_data.id;
      var oldClass = newItemTemplate.classList[0];
      newItemTemplate.classList.replace( oldClass, newClass );
      
      var delItemTemplate = taskTemplate.querySelector('.del-answer-link');
      delItemTemplate.setAttribute('href',"/answers/" +  _data.id);
      delItemTemplate.dataset.answerId = _data.id; 
      
      var editItemTemplate = taskTemplate.querySelector('.edit-answer-link');
      editItemTemplate.setAttribute('href',"");
//      editItemTemplate.setAttribute('href',"/answers/" +  _data.id);
      editItemTemplate.dataset.answerId = _data.id; 
            
      var editItemDetail = taskTemplate.querySelector('.edit_answer');
      editItemDetail.style.display = 'block';

      editItemDetail.setAttribute('action',"/answers/" + _data.id + ".js");
      editItemDetail.setAttribute('id',"/answers/" + _data.id + ".js");
      /*
      var taskBodyDet  =  document.querySelector('#answer_body');
      var taskBestDet  =  editItemDetail.querySelector('#answer_best');
    
      taskBodyDet.textContent = _data.body;

      if (_data.best) { 
        taskBestDet.textContent = 'Лучший';
      } else {
        taskBestDet.textContent = '';
      }
      */

      editItemDetail.setAttribute('body', _data.body);


      var editItemDetailBtn = editItemDetail.querySelector('.btn');
      
      oldClass = editItemDetailBtn.classList[0];
      newClass = "answer_btn_"+_data.id;
      editItemDetailBtn.classList.replace( oldClass, newClass );

       editItemDetail.style.display = 'none';
            
      var showItemTemplate = taskTemplate.querySelector('.show-answer-link');
      showItemTemplate.setAttribute('href',"/answers/" + _data.id);

      var clonedElement = newItemTemplate.cloneNode(true);
      var taskBody  =  clonedElement.querySelector('#answerBody');
      var taskBest  =  clonedElement.querySelector('#answerBest');
      
      var taskFiles =  clonedElement.querySelector('.answerFile');
      
      taskBody.textContent = _data.id;
      taskBody.textContent = _data.body;
      if (_data.best) { 
        taskBest.textContent = 'Лучший';
      } else {
        taskBest.textContent = '';
      }
      var editItemClonedElement = clonedElement.querySelector('.edit_answer');
      editItemClonedElement.style.display = 'block';
      var taskBodyDetCl  =  editItemClonedElement.querySelector('#answer_body');
      var taskBestDetCl  =  editItemClonedElement.querySelector('#answer_best');

      taskBodyDetCl.textContent = _data.body;
      if (_data.best) { 
        taskBestDetCl.textContent = 'Лучший';
      } else {
        taskBestDetCl.textContent = '';
      }
      editItemClonedElement.style.display = 'none';

      var textLink = '';
      _data.files.forEach(function(element) {
        name = element.file.url.split('/').pop();
        textLink  = textLink + "<li class = 'answerFile' ><a href=" + element.file.url + ">" + name + "</a></li>";
      });
      taskFiles.innerHTML =  textLink ;
      var last_row = tabl.appendChild(clonedElement);

      var current_row = document.querySelector(".answer_row_"+_data.id); 

      /*last_row.innerHTML = _data.body;
      tabl.appendChild(last_row);  */
  
      form_answer.answer_best.value ='';
      form_answer.answer_body.value ='';

      document.querySelector('.answers_container').style.display = 'none';

      var del_links_list = current_row.querySelectorAll('.del-answer-link');

      del_links_list.forEach(element => {
        element.onclick = function(e) {
          e.preventDefault();
          this.style.display = 'none';
        }
      });

      var edit_links_list = current_row.querySelectorAll('.edit-answer-link')
   
      edit_links_list.forEach(element => {
        element.onclick = function(e) {
          e.preventDefault();
          editItemDetail = current_row.querySelector('.edit_answer');
          editItemDetail.style.display = 'block';
        }
      });
    
    
 
    });

    form_answer.addEventListener("ajax:error", (event) => {
      var answerErrors = document.querySelector('.answer-errors');
      const [,, xhr] = event.detail;
      answerErrors.style.color = 'red';
      answerErrors.style.fontSize = '20px';
      answerErrors.insertAdjacentHTML("beforeend", xhr.responseText); 
     });
   
 
  } else {
    console.log('=====================');
  };

  } 

}
 
  var edit_links_list = document.querySelectorAll('.edit-answer-link')
  edit_links_list.forEach(element => {
    element.onclick = function(e) {
      e.preventDefault();
      var forms = document.querySelectorAll('.edit_answer');
      forms.forEach(form => {
        form.style.display = 'none';
      });
      this.style.display = 'none';
      var answer_id = this.dataset.answerId;
      //console.log(answer_id);
      document.getElementById('edit-answer-' + answer_id).style.display = 'block';

    }
  });
/*
  var del_links_list = document.querySelectorAll('.del-answer-link')
  del_links_list.forEach(element => {
    element.onclick = function(e) {
      e.preventDefault();
      this.style.display = 'none';
    }
  });
  */

  var edit_comment_list = document.querySelectorAll('.edit-comment-link')
  edit_comment_list.forEach(element => {
    element.onclick = function(e) {
      e.preventDefault();
      var forms = document.querySelectorAll('.edit_comment');
      forms.forEach(form => {
        form.style.display = 'none';
      });
      this.style.display = 'none';
      var comment_id = this.dataset.commentId;
//      console.log(document.getElementById('edit-comment-' + comment_id));
     // document.getElementById('edit-comment-' + comment_id).style.display = 'block';
    }
  });


  var del_comment_list = document.querySelectorAll('.del-comment-link')
  del_comment_list.forEach(element => {
    element.onclick = function(e) {
      e.preventDefault();
      this.style.display = 'none';
    }
  });


/*
 var tabl = document.querySelector('.answers_table');
   var current_row = document.querySelector(".answer_row_394");
   current_row.remove();
*/



/*
window.addEventListener("load", () => {
  const links = document.querySelectorAll("a[data-remote]");
  links.forEach((element) => {
    element.addEventListener("ajax:success", () => {
      alert("The article was deleted.");
    });
  });
});
*/
/* \\import {} from 'jquery-ujs' */
/* \\= require jquery_ujs */
/* \\= require jquery_nested_form */

});
/*
form_answer.addEventListener("ajax:error", () => {
   form_answer.insertAdjacentHTML("beforeend", "<p>ERROR</p>"); 
});
*/
 /*
  var oknoNewAnswer = document.querySelector('.answers_container');
  var form_answer = document.querySelector(".new_answer");
  if (form_answer)  {
   $('form_answer').on("ajax:complete", function(xhr, status) {
      console.log('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!')
      var tabl = document.querySelector('.answers_table');
      var last_row = tabl.createElement('tr');
      console.log('hello world')
      console.log(xhr.responseText);
      last_row.innerHTML = xhr.responseText;
      tabl.appendChild(last_row);
    });
  } else {
    console.log('=====================');
  };
  */ 

        // console.log(JST["templates/answer_row"]({world: "World"}));
      //last_row.innerHTML = JST["templates/answer_row"]({world: "World"})
   /*last_row.innerHTML = "<%= j render 'questions/answer_row', answer: _data %>"; */
   /* form_answer.insertAdjacentHTML("beforeend", _data); */

         /*
      var tabl = document.querySelector('.answers_table');
      var tablEnd = tabl.rows.item(tabl.rows.length-1);
      console.log('-------------=====-----');
      console.log(tablEnd);
      */
/////\\\= require_self
/////\\\= require_tree ./channels
/////\\\= app/assets/javascripts/cable.js

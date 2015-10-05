$(document).ready(function () {

  var $tasks = $('.task');

  $('#task_filter_status').on('change', function () {
    var currentStatus = this.value;
    if (currentStatus === "all") {
      $tasks.each(function (index, task){
        $task = $(task);
        $task.show();
      });
    } else {
      $tasks.each(function (index, task) {
        $task = $(task);
        if ($task.data('status') === currentStatus) {
          $task.show();
        } else {
          $task.hide();
        }
      });
    }
  });

  $('#task_filter_date').on('change', function () {
    var currentDate = this.value;
    if (currentDate === "all" || !currentDate) {
      $tasks.each(function (index, task){
        $task = $(task);
        $task.show();
      });
    } else {
      $tasks.each(function (index, task) {
        $task = $(task);
        if ($task.data('due-date') === currentDate) {
          $task.show();
        } else {
          $task.hide();
        }
      });
    }
  });

  $('#task_filter_name').on('keyup', function (){
    var searchTerm = this.value.toLowerCase();
    $('.task').each(function (index, task) {
      var title = $(task).children('h4').text().toLowerCase();
      var matches = title.indexOf(searchTerm) !== -1;
      $(task).toggle(matches);
    });
  });
});
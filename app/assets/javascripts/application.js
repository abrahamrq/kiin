// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require dataTables/jquery.dataTables
<<<<<<< HEAD
=======
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require dataTables/jquery.dataTables
//= require turbolinks
>>>>>>> 12213b0b1f95767f09b1949edff02db21f3064dc
//= require bootstrap 
//= require common
//= require moment
//= require fullcalendar

$(function(){
  $('.datatable').DataTable({
    "scrollX": true,
    "aoColumnDefs" : [ { "bSortable": false, "aTargets" : [ "no-sort" ] } ],
    // si se cambia spanish por cualquier idioma las tablas cambian de idioma
    "language": {
            "url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Spanish.json"
        }
  });
});

//= require turbolinks


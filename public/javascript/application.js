$(function() {
  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()

  // specify the data type as JSON
  // $.get()
  // $.post()
  // $.getJSON()
  // $.ajax()

  // initializing
  var contacts = [];
  var phones = "";

  $( "#navbar button" ).on( "click", function() {
    // hide all visible '.main' views
    $( ".main" ).hide();

    // remove any output from other views
    $( ".show_all" ).remove();
    
    // set 'id' to button.id after removing 'b_' from the start and then show it
    var id = this.id.substring(2, this.id.length);
    $( "#" + id ).show();

    // empty search box on 'find' view
    $( "#search_box" ).val('');
  });

  // phone mash


  // process list
  function iterator(data) {
    contacts = [];
    $.each( data, function( key, val ) {
      phones = "";
      $.each( val.digits, function( key, val ) {
        phones = phones.concat(" | " + val.phone + " (" + val.label + ")");
      });
      contacts.push( 
        "<li id='" + key + "'>"
        + val.contact.id + ": "
        + val.contact.firstname + " "
        + val.contact.lastname
        + " (" + val.contact.email + ")"
        + phones
        + "</li>"
      );
    });
  }

  // display list
  function list(contacts) {
    $( "<ul/>", {
      "class": "show_all",
      html: contacts.join( "" )
    }).appendTo( "#show" );
  }

  $( "#b_list_all" ).on( "click", function() {
    // e.preventDefault();
    $.getJSON( "/contacts", function( data ) {
      iterator(data);
     
      if ($("h3:visible")[0].innerText == "List all") {
        list(contacts);
      }
    });
  });

  var delay = (function(){
    var timer = 0;
    return function(callback, ms){
      clearTimeout (timer);
      timer = setTimeout(callback, ms);
    };
  })();

  $( "#search_box" ).on( "keyup", function() {
    var self = this;
    delay(function(){
      var search_string = $( self ).val();
      $( ".show_all").remove();

      $.getJSON( "/contacts/find?query=" + search_string, function( data ) {
        iterator(data);

        if ($("h3:visible")[0].innerText == "Find") {
          list(contacts);
        }
      });
    }, 500 );
  });

  $( "#b_delete_id" ).on( "click", function() {
    var id = $( "#delete_id" ).val();
    $.get( "/contact/delete/" + id );
    $( "#delete_id" ).val('');
    $("#deleted").fadeIn('slow').fadeOut('slow');
  });

  $( "#b_save" ).on( "click", function() {
    var firstname = $( "#firstname" ).val();
    var lastname = $( "#lastname" ).val();
    var email = $( "#email" ).val();
    var url = "/contact/new" // /?firstname=" + firstname + "&lastname=" + lastname + "&email=" + email;
    var newUser = {firstname: firstname, lastname: lastname, email: email};
    $.post( url, newUser, function (data) {
      data = JSON.parse(data);
      if (data.result) {
        $( "#firstname" ).val('');
        $( "#lastname" ).val('');
        $( "#email" ).val('');
        $( "#saved" ).fadeIn('slow').fadeOut('slow');
      } else {
        alert("STB");
      }
    });
  });

  $( "#b_save_phone" ).on( "click", function() {
    var phone = $( "#phone" ).val();
    var label = $( "#label" ).val();
    var contact_id = $( "#contact_id" ).val();
    var newPhone = {phone: phone, label: label, contact_id: contact_id};
    $.post( '/contact/phone/new', newPhone, function (data) {
      data = JSON.parse(data);
      if (data.result) {
        $( "#phone" ).val('');
        $( "#label" ).val('');
        $( "#contact_id" ).val('');
        $( "#saved_phone" ).fadeIn('slow').fadeOut('slow');
      } else {
        alert("STB");
      }
    });
  });

});

var reportDrillReceiptMetadata = Titanium.UI.createView({
    top: 0,
    width: 320,
    height: 420,
    opacity: 1,
    title: ''
});

function handleSelectPeople( event )
{
    Ti.API.info("selecting people");
    Titanium.Contacts.showContacts({
        success: function(e) {
            Ti.API.log("stuff");
        },
        animated: true
    });

}

var selectPeoplePresentButton = Titanium.UI.createButton(
    {
        title : 'Select People Present',
        size :
            {
                height: 100,
                width: 250
            }
    });
selectPeoplePresentButton.addEventListener("click", handleSelectPeople);
reportDrillReceiptMetadata.add( selectPeoplePresentButton );




//var ta1 = Titanium.UI.createTextArea({
//    value:'I am a textarea',
//    height:70,
//    width:300
//    });   
//reportDrillReceiptMetadata.add( ta1 );
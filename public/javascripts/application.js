// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function prepare_hovers() {
    var old_plus = $('addnew_plus').getStyle('color');
    var old_O = $('random_O').getStyle('color');
    $('addnew').observe('mouseover', function() {
        $('addnew_plus').setStyle({
            color: '#007711',
        });
    });
    $('addnew').observe('mouseout', function() {
        $('addnew_plus').setStyle({
            color: old_plus,
        });
    });
    $('random').observe('mouseover', function() {
        $('random_O').setStyle({
            color: '#001177',
        });
    });
    $('random').observe('mouseout', function() {
        $('random_O').setStyle({
            color: old_O,
        });
    });
}

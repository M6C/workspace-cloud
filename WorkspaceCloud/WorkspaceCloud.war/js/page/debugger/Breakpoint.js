function find_TD_at_Line(line, column) {
//alert("find_TD_at_Line");
    var div = document.getElementById("text");
    var table = div.getElementsByTagName("table");
    var tr = div.getElementsByTagName("tr")[line-1];
    var td = tr.getElementsByTagName("td")[column];
    return td;
}

function showBreakpoint(line, text) {
//alert("showBreakpoint1");
      var td = find_TD_at_Line(line, 0);
//alert("showBreakpoint2");
    td.id = (text=="added") ? "breakpoint" : "";
//alert("showBreakpoint3");
}
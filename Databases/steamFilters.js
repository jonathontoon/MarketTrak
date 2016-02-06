var filters = document.getElementsByClassName("econ_tag_filter_category")
var filterArray = new Array();

for (i = 0; i<5; i++) {
  var select = filters[i].querySelector("select[name]");
  var name = filters[i].getElementsByClassName("econ_tag_filter_category_label")[0].innerHTML;
  var selector = new Object();
      selector.name = name;
      selector.category = select.name;
      selector.options = [];

  for(j = 0; j<select.length; j++) {
      var option = select.children[j];
      selector.options.push({
        "name": option.text,
        "tag": option.value,
      });
      console.log(option.text, option.value);
  }

  filterArray.push(selector);
}

for (l = 4; l<11; l++) {

  var inputName = filters[l].querySelector("div.econ_tag_filter_category_label").innerHTML;
  var inputs = filters[l].getElementsByClassName("econ_tag_filter_container");

  var selector = new Object();
      selector.name = inputName;
      selector.options = [];

      for(m = 0; m<inputs.length; m++) {
        var input = inputs[m].querySelector("input.econ_tag_filter_checkbox");
        var title = inputs[m].querySelector("label.econ_tag_filter_label span");

        console.log(input, title);

        selector.category = input.name

        selector.options.push({
          "name": title.innerHTML,
          "tag": input.value
        });

        filterArray.push(selector);

      }
}

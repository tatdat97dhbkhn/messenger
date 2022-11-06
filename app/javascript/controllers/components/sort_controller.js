import BaseController from "../base_controller";

export default class extends BaseController {
  initialize() {
    this.initialModifyRecords(this.element);
    this.mutationObserver(this.element);
  }

  mutationObserver(records) {
    const config = { attributes: true, childList: true, subtree: true };

    const callback = (mutationsList, observer) => {
      for (const mutation of mutationsList) {
        if (mutation.type === "childList") {
          console.log("A child node has been added or removed.");
          const sortedList = sortByColumn(records);

          modifyRecords(records, sortedList, observer, config);
        }
      }
    };

    const observer = new MutationObserver(callback);
    observer.observe(records, config);
  }

  initialModifyRecords(records) {
    const sortedList = sortByColumn(records);
    records.innerHTML = "";
    sortedList.forEach((record) => {
      records.appendChild(record);
    });
  }
}

function modifyRecords(records, sortedList, observer, config) {
  observer.disconnect();
  records.innerHTML = "";
  sortedList.forEach((record) => {
    records.appendChild(record);
  });
  observer.observe(records, config);
}

function sortByColumn(records) {
  const recordList = records.querySelectorAll(".sort-item");

  return Array.from(recordList).sort((a, b) => {
    const aSortColumn = a.querySelector(".sort-column")?.dataset?.time;
    const bSortColumn = b.querySelector(".sort-column")?.dataset?.time;

    if (aSortColumn === undefined) {
      return 1;
    } else if (bSortColumn === undefined) {
      return -1;
    } else {
      return aSortColumn > bSortColumn ? -1 : 1;
    }
  });
}

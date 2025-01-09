import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        this.hideAfterDelay();
    }

    hideAfterDelay() {
        setTimeout(() => {
            this.element.classList.add("opacity-0", "transition-opacity", "duration-500");

            setTimeout(() => {
                this.element.remove();
            }, 500);
        }, 5000);
    }
}

import {Socket} from "phoenix";

export default class StoryObserver {
  constructor(storyId) {
    this.storyId = storyId;
    this.socket = new Socket("/socket");
    this.socket.connect();
    this.channel = this.socket.channel(`stories:${storyId}`, {userId: window.userId});
    this.channel.join()
      .receive("ok", resp => { console.log("Joined successfully", resp) })
      .receive("error", resp => { console.log("Unable to join", resp) });

    this.channel.on("login", (login) => {
      console.log(`${login.userId} logged in.`);
    });
  }

}

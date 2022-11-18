function getRandom(from, to) {
  return Math.floor(Math.random() * (to - from)) + from;
}

const app = Vue.createApp({
  data() {
    return {
      monsterHealth: 100,
      playerHealth: 100,
      counter: 0,
      winner: null,
      battleLog: [],
    };
  },
  watch: {
    playerHealth(value) {
      if (value <= 0 && this.monsterHealth <= 0) {
        this.winner = "draw";
      } else if (value <= 0) {
        this.winner = "monster";
      }
    },
    monsterHealth(value) {
      if (value <= 0 && this.playerHealth <= 0) {
        this.winner = "draw";
      } else if (value <= 0) {
        this.winner = "player";
      }
    },
  },
  computed: {
    noSpecial() {
      return this.counter != 0 || this.isEnd;
    },
    isEnd() {
      return this.winner !== null;
    },
    monsterStyle() {
      if (this.monsterHealth < 0) return { width: "0%" };
      return { width: this.monsterHealth + "%" };
    },
    playerStyle() {
      if (this.playerHealth < 0) return { width: "0%" };
      return { width: this.playerHealth + "%" };
    },
  },
  methods: {
    attackMonster() {
      if (this.counter > 0) this.counter--;
      const damage = getRandom(5, 12);
      this.monsterHealth -= damage;
      this.addLog("You", `${damage} damages`, "Monster");
      this.attackPlayer();
    },
    attackPlayer() {
      if (this.counter > 0) this.counter--;
      const damage = getRandom(8, 16);
      this.playerHealth -= damage;
      this.addLog("Monster", `${damage} damages`, "You");
    },
    specialAttack() {
      this.counter = 4;
      const damage = getRandom(16, 24);
      this.monsterHealth -= damage;
      this.addLog("You", `${damage} damages`, "Monster");
      this.attackPlayer();
    },
    heal() {
      const health = getRandom(8, 16);
      this.playerHealth += health;
      this.addLog("You", `${health} heals`, "Yourself");
      if (this.playerHealth >= 100) this.playerHealth = 100;
    },
    surrender() {
      this.winner = "monster";
    },
    addLog(who, what, to) {
      this.battleLog.unshift(`${who} make ${what} to ${to}`);
    },
    restart() {
      this.monsterHealth = 100;
      this.playerHealth = 100;
      this.counter = 0;
      this.winner = null;
      this.battleLog = [];
    },
  },
});

app.mount("#game");

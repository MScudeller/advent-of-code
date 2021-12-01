package days

import java.util.*
import kotlin.math.absoluteValue

class Day09(rawInput: List<String>) : Day {

    private val playerQuantity: Int
    private val lastMarble: Int

    init {
        val result = """(\d*) players; last marble is worth (\d*) points""".toRegex().find(rawInput.first())!!
        val (playerQuantity, lastMarble) = result.destructured
        this.playerQuantity = playerQuantity.toInt()
        this.lastMarble = lastMarble.toInt()
    }


    override fun part1() {
        val game = Game(playerQuantity)
        val score =  game.play(lastMarble)
        println(score)
    }

    override fun part2() {
        val game = Game(playerQuantity)
        val score =  game.play(lastMarble * 100)
        println(score)
    }

    class Game(playerQuantity: Int) {
        private val marbles = ArrayDeque<Int>().also { it.add(0) }
        private val players = LongArray(playerQuantity)

        fun play(maxMarbles: Int): Long {
            for (marble in 1..(maxMarbles)) {
                if (marble % 23 == 0) {
                    players[marble % players.size] += marble + with(marbles) {
                        shift(-7)
                        removeFirst().toLong()
                    }
                    marbles.shift(1)
                } else {
                    with(marbles) {
                        shift(1)
                        addFirst(marble)
                    }
                }
            }
            return players.max()!!
        }

        private fun <T> Deque<T>.shift(n: Int): Unit =
            if (n < 0) repeat(n.absoluteValue) {
                addLast(removeFirst())
            } else repeat(n) {
                addFirst(removeLast())
            }
    }


}
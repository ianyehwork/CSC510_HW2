import java.util.Random

val rand = Random(0) // using a seed to produce same output on each run

enum class Pattern {RANDOM }

class Field(val v1: Int, val v2: Int) {
    val s = List(v2) { BooleanArray(v1) }

    operator fun set(x: Int, y: Int, b: Boolean) {
        s[y][x] = b
    }

    fun next(x: Int, y: Int): Boolean {
        var on = 0
        for (i in -1..1) {
            for (j in -1..1) {
                if (state(x + i, y + j) && !(j == 0 && i == 0)) on++
            }
        }
        return on == 3 || (on == 2 && state(x, y))
    }

    fun state(x: Int, y: Int): Boolean {
        if ((x !in 0 until v1) || (y !in 0 until v2)) return false
        return s[y][x]
    }
}

class Life(val pattern: Pattern) {
    val v1: Int
    val v2: Int
    var v3: Field
    var v4: Field

    init {
        when (pattern) {

            Pattern.RANDOM -> {
                v1 = 80
                v2 = 15
                v3 = Field(v1, v2)
                v4 = Field(v1, v2)
                for (i in 0 until v1 * v2 / 2) {
                    v3[rand.nextInt(v1), rand.nextInt(v2)] = true
                }
            }
        }
    }

    fun step() {
        for (y in 0 until v2) {
            for (x in 0 until v1) {
                v4[x, y] = v3.next(x, y)
            }
        }
        val t = v3
        v3 = v4
        v4 = t
    }

    override fun toString(): String {
        val sb = StringBuilder()
        for (y in 0 until v2) {
            for (x in 0 until v1) {
                val c = if (v3.state(x, y)) '#' else '.'
                sb.append(c)
            }
            sb.append('\n')
        }
        return sb.toString()
    }
}

fun main(args: Array<String>) {
    val lives = listOf(
        Triple(Life(Pattern.RANDOM), 100, "RANDOM")
    )
    for ((game, gens, title) in lives) {
        println("$title:\n")
        repeat(gens + 1) {
            println("Generation: $it\n$game")
            Thread.sleep(30)
            game.step()
        }
        println()
    }
}
import days.*
import java.io.File

class DayFactory {
    fun buildDay(day: Int): Day {
        val dayString = "day${day.toString().padStart(2, '0')}"
        return when (day) {
            1 -> Day01(readInputFile(dayString))
            2 -> Day02(readInputFile(dayString))
            3 -> Day03(readInputFile(dayString))
            4 -> Day04(readInputFile(dayString))
            5 -> Day05(readInputFile(dayString))
            6 -> Day06(readInputFile(dayString))
            7 -> Day07(readInputFile(dayString))
            8 -> Day08(readInputFile(dayString))
            9 -> Day09(readInputFile(dayString))
            10 -> Day10(readInputFile(dayString))
            else -> throw IllegalArgumentException("day")
        }
    }

    private fun readInputFile(fileName: String): List<String> {
        return File("inputs/$fileName").readText().split("\r\n")
    }
}
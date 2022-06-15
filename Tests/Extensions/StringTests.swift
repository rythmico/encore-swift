import Extensions
import XCTest

final class StringTests: XCTestCase {
    func testIsBlank() {
        XCTAssertEqual("".isBlank, true)
        XCTAssertEqual(" ".isBlank, true)
        XCTAssertEqual("\n".isBlank, true)
        XCTAssertEqual("          ".isBlank, true)
        XCTAssertEqual("     \n     ".isBlank, true)
        XCTAssertEqual("     \n          \n ".isBlank, true)
        XCTAssertEqual("     \n          \r ".isBlank, true)
        XCTAssertEqual("     a           ".isBlank, false)
        XCTAssertEqual("     a      \n     ".isBlank, false)
    }

    func testNilIfBlank() {
        XCTAssertEqual("".nilIfBlank, nil)
        XCTAssertEqual(" ".nilIfBlank, nil)
        XCTAssertEqual("\n".nilIfBlank, nil)
        XCTAssertEqual("          ".nilIfBlank, nil)
        XCTAssertEqual("     \n     ".nilIfBlank, nil)
        XCTAssertEqual("     \n          \n ".nilIfBlank, nil)
        XCTAssertEqual("     \n          \r ".nilIfBlank, nil)
        XCTAssertEqual("     a           ".nilIfBlank, "     a           ")
        XCTAssertEqual("     a      \n     ".nilIfBlank, "     a      \n     ")
    }

    func testQuoted() {
        XCTAssertEqual("".quoted(), #""""#)
        XCTAssertEqual("      ".quoted(), #""      ""#)
        XCTAssertEqual("\n".quoted(), "\"\n\"")
        XCTAssertEqual("David Roman".quoted(), #""David Roman""#)
    }

    func testSmartQuoted() {
        XCTAssertEqual("".smartQuoted(), "“”")
        XCTAssertEqual("      ".smartQuoted(), "“      ”")
        XCTAssertEqual("\n".smartQuoted(), "“\n”")
        XCTAssertEqual("David Roman".smartQuoted(), "“David Roman”")
    }

    func testParenthesized() {
        XCTAssertEqual("".parenthesized(), "()")
        XCTAssertEqual("      ".parenthesized(), "(      )")
        XCTAssertEqual("\n".parenthesized(), "(\n)")
        XCTAssertEqual("David Roman".parenthesized(), "(David Roman)")
    }

    func testRepeated() {
        let sut: String = "a"
        XCTAssertEqual(sut.repeated(), "aa")
        XCTAssertEqual(sut.repeated(1), "a")
        XCTAssertEqual(sut.repeated(2), "aa")
        XCTAssertEqual(sut.repeated(3), "aaa")
        XCTAssertEqual(sut.repeated(4), "aaaa")
        XCTAssertEqual(sut.repeated(5), "aaaaa")
    }

    func testRepeatedEmoji() {
        let sut: String = "🔥"
        XCTAssertEqual(sut.repeated(), "🔥🔥")
        XCTAssertEqual(sut.repeated(1), "🔥")
        XCTAssertEqual(sut.repeated(2), "🔥🔥")
        XCTAssertEqual(sut.repeated(3), "🔥🔥🔥")
        XCTAssertEqual(sut.repeated(4), "🔥🔥🔥🔥")
        XCTAssertEqual(sut.repeated(5), "🔥🔥🔥🔥🔥")
    }

    func testRemovingRepetition() {
        XCTAssertEqual("".removingRepetition(of: "a"), "")
        XCTAssertEqual("a".removingRepetition(of: "a"), "a")
        XCTAssertEqual("bca".removingRepetition(of: "a"), "bca")
        XCTAssertEqual("aaaaa bca xc".removingRepetition(of: "a"), "a bca xc")
        XCTAssertEqual("bca aa xc".removingRepetition(of: "a"), "bca a xc")
        XCTAssertEqual("bcaaa xc".removingRepetition(of: "a"), "bca xc")
    }

    func testTrimmingLineCharacters() {
        XCTAssertEqual(
            """
                 tempora
              et
            id
                 porro
                    illum
            """.trimmingLineCharacters(in: .whitespacesAndNewlines),
            """
            tempora
            et
            id
            porro
            illum
            """
        )
    }

    func testWords() {
        XCTAssertEqual("".words, [])
        XCTAssertEqual("   ".words, [])

        XCTAssertEqual("  David     ".words, ["David"])
        XCTAssertEqual("David   Roman".words, ["David", "Roman"])
        XCTAssertEqual("  David    Roman ".words, ["David", "Roman"])
        XCTAssertEqual(" \n David  \n\n  Roman ".words, ["David", "Roman"])
        XCTAssertEqual(" \n David  \n\n  Roman ".words, ["David", "Roman"])

        XCTAssertEqual("David Roman Aguirre Gonzalez".words, ["David", "Roman", "Aguirre", "Gonzalez"])
    }

    func testWordAtIndex() {
        XCTAssertEqual("".word(at: 0), nil)
        XCTAssertEqual("   ".word(at: 0), nil)

        XCTAssertEqual("  David     ".word(at: 0), "David")
        XCTAssertEqual("David   Roman".word(at: 0), "David")
        XCTAssertEqual("  David    Roman ".word(at: 0), "David")
        XCTAssertEqual(" \n David  \n\n  Roman ".word(at: 0), "David")
        XCTAssertEqual(" \n David  \n\n  Roman ".word(at: 1), "Roman")

        XCTAssertEqual("David Roman Aguirre Gonzalez".word(at: -1), nil)
        XCTAssertEqual("David Roman Aguirre Gonzalez".word(at: 0), "David")
        XCTAssertEqual("David Roman Aguirre Gonzalez".word(at: 1), "Roman")
        XCTAssertEqual("David Roman Aguirre Gonzalez".word(at: 2), "Aguirre")
        XCTAssertEqual("David Roman Aguirre Gonzalez".word(at: 3), "Gonzalez")
        XCTAssertEqual("David Roman Aguirre Gonzalez".word(at: 4), nil)
        XCTAssertEqual("David Roman Aguirre Gonzalez".word(at: 5), nil)
    }

    func testInitials() {
        XCTAssertEqual("".initials(), "")
        XCTAssertEqual("   ".initials(), "")

        XCTAssertEqual("  David     ".initials(), "D")
        XCTAssertEqual("David   Roman".initials(), "DR")
        XCTAssertEqual("  David    Roman ".initials(), "DR")

        XCTAssertEqual("David".initials(), "D")
        XCTAssertEqual("David Roman".initials(), "DR")
        XCTAssertEqual("David Roman Aguirre".initials(), "DRA")
        XCTAssertEqual("David Roman Aguirre Gonzalez".initials(), "DRAG")
    }

    func testInitials_0() {
        XCTAssertEqual("".initials(0), "")
        XCTAssertEqual("   ".initials(0), "")

        XCTAssertEqual("  David     ".initials(0), "")
        XCTAssertEqual("David   Roman".initials(0), "")
        XCTAssertEqual("  David    Roman ".initials(0), "")

        XCTAssertEqual("David".initials(0), "")
        XCTAssertEqual("David Roman".initials(0), "")
        XCTAssertEqual("David Roman Aguirre".initials(0), "")
        XCTAssertEqual("David Roman Aguirre Gonzalez".initials(0), "")
    }

    func testInitials_1() {
        XCTAssertEqual("".initials(1), "")
        XCTAssertEqual("   ".initials(1), "")

        XCTAssertEqual("  David     ".initials(1), "D")
        XCTAssertEqual("David   Roman".initials(1), "D")
        XCTAssertEqual("  David    Roman ".initials(1), "D")

        XCTAssertEqual("David".initials(1), "D")
        XCTAssertEqual("David Roman".initials(1), "D")
        XCTAssertEqual("David Roman Aguirre".initials(1), "D")
        XCTAssertEqual("David Roman Aguirre Gonzalez".initials(1), "D")
    }

    func testInitials_2() {
        XCTAssertEqual("".initials(2), "")
        XCTAssertEqual("   ".initials(2), "")

        XCTAssertEqual("  David     ".initials(2), "D")
        XCTAssertEqual("David   Roman".initials(2), "DR")
        XCTAssertEqual("  David    Roman ".initials(2), "DR")

        XCTAssertEqual("David".initials(2), "D")
        XCTAssertEqual("David Roman".initials(2), "DR")
        XCTAssertEqual("David Roman Aguirre".initials(2), "DR")
        XCTAssertEqual("David Roman Aguirre Gonzalez".initials(2), "DR")
    }

    func testInitials_5() {
        XCTAssertEqual("".initials(), "")
        XCTAssertEqual("   ".initials(), "")

        XCTAssertEqual("  David     ".initials(), "D")
        XCTAssertEqual("David   Roman".initials(), "DR")
        XCTAssertEqual("  David    Roman ".initials(), "DR")

        XCTAssertEqual("David".initials(), "D")
        XCTAssertEqual("David Roman".initials(), "DR")
        XCTAssertEqual("David Roman Aguirre".initials(), "DRA")
        XCTAssertEqual("David Roman Aguirre Gonzalez".initials(), "DRAG")
    }

    func testSpaced() {
        XCTAssertEqual(["David"].spaced(), "David")
        XCTAssertEqual(["David", "Roman"].spaced(), "David Roman")
        XCTAssertEqual(["David", "Roman", "Aguirre"].spaced(), "David Roman Aguirre")
        XCTAssertEqual(["", "David", "Roman", "",  "Aguirre"].spaced(), " David Roman  Aguirre")
        XCTAssertEqual(["David", "Roman", "Aguirre", "Gonzalez"].spaced(), "David Roman Aguirre Gonzalez")
    }

    func testSpacedAndDashed() {
        XCTAssertEqual(["David"].spacedAndDashed(), "David")
        XCTAssertEqual(["David", "Roman"].spacedAndDashed(), "David - Roman")
        XCTAssertEqual(["David", "Roman", "Aguirre"].spacedAndDashed(), "David - Roman - Aguirre")
        XCTAssertEqual(["", "David", "Roman", "",  "Aguirre"].spacedAndDashed(), " - David - Roman -  - Aguirre")
        XCTAssertEqual(["David", "Roman", "Aguirre", "Gonzalez"].spacedAndDashed(), "David - Roman - Aguirre - Gonzalez")
    }

    func testRandom() {
        let sut = String.random
        XCTAssertEqual(sut(24).count, 24)
        XCTAssertEqual(sut(24).count, 24)
        XCTAssertEqual(sut(24).count, 24)
        XCTAssertEqual(sut(24).count, 24)
        XCTAssertNotEqual(sut(24), sut(24))
        XCTAssertNotEqual(sut(24), sut(24))
        XCTAssertNotEqual(sut(24), sut(24))
        XCTAssertNotEqual(sut(24), sut(24))

        struct SeedableRandomNumberGenerator: RandomNumberGenerator {
            var seed: UInt64

            mutating func next() -> UInt64 {
                seed = 2862933555777941757 &* seed &+ 3037000493
                return seed
            }
        }

        var rng = SeedableRandomNumberGenerator(seed: 0)
        XCTAssertEqual(.random(using: &rng), "ax1DqpAeOJ7wkkto")
        XCTAssertEqual(.random(using: &rng), "yhq4vBPmQvyVXF9h")
        XCTAssertEqual(.random(using: &rng), "oUbSellYLdr0WOLX")
        XCTAssertEqual(.random(using: &rng), "5BnEfJ899bHXcGIw")
    }
}

# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

XO is a SwiftUI-based Tic Tac Toe game for iOS/macOS. The game features a player vs. computer mode where the player uses X and the computer uses O with random move selection.

## Architecture

### Core Components

- **xoApp.swift**: Main app entry point using SwiftUI's `@main` App protocol
- **ContentView.swift**: Single-view game implementation containing:
  - Game state management (`@State` properties for board, currentPlayer, winner)
  - UI rendering (3x3 grid using nested ForEach loops)
  - Game logic (move validation, win checking, computer AI)
  - Visual assets (uses Image assets "X" and "O" from Assets.xcassets)

### Game Logic Flow

1. Player makes move → `makeMove(row:column:)` updates board
2. `checkForWinner()` validates game state (rows, columns, diagonals, draw)
3. If no winner, switches to computer player
4. Computer selects random available move → `makeComputerMove()`
5. Repeats until win condition or draw

### Test Structure

- **xoTests/**: Unit tests using Swift Testing framework (`import Testing`)
- **xoUITests/**: UI tests using XCTest framework with XCUIApplication

## Development Commands

### Building and Running

**Open in Xcode:**
```bash
open xo.xcodeproj
```

**Build from command line** (requires full Xcode installation):
```bash
xcodebuild -scheme xo -configuration Debug build
```

**Run tests:**
```bash
# Unit tests
xcodebuild test -scheme xo -destination 'platform=iOS Simulator,name=iPhone 15'

# UI tests  
xcodebuild test -scheme xo -only-testing:xoUITests -destination 'platform=iOS Simulator,name=iPhone 15'
```

### Testing Notes

- Unit tests use the modern Swift Testing framework (not XCTest)
- Import the app module with `@testable import xo` for internal access
- UI tests use XCTest and XCUIApplication for automation

## Key Implementation Details

### State Management
All game state is managed via SwiftUI `@State` properties in ContentView—no separate model layer or ViewModels are used.

### Computer AI
The computer opponent uses a simple random selection from available moves (`availableMoves.randomElement()`). There's a 1-second delay before computer moves for better UX (`DispatchQueue.main.asyncAfter`).

### Win Detection
The `checkForWinner()` function checks in order:
1. Horizontal rows (3 checks)
2. Vertical columns (3 checks)
3. Diagonals (2 checks)
4. Draw condition (no empty spaces)

### Visual Design
- Uses custom Image assets ("X" and "O") instead of text labels
- 80x80pt cells with black borders
- Restart button with blue background
- Winner announcement in green text

/*
 * Radiant Player.h
 */

#import <AppKit/AppKit.h>
#import <ScriptingBridge/ScriptingBridge.h>


@class RadiantPlayerApplication, RadiantPlayerDocument, RadiantPlayerWindow, RadiantPlayerApplication;

enum RadiantPlayerSaveOptions {
	RadiantPlayerSaveOptionsYes = 'yes ' /* Save the file. */,
	RadiantPlayerSaveOptionsNo = 'no  ' /* Do not save the file. */,
	RadiantPlayerSaveOptionsAsk = 'ask ' /* Ask the user whether or not to save the file. */
};
typedef enum RadiantPlayerSaveOptions RadiantPlayerSaveOptions;

enum RadiantPlayerPrintingErrorHandling {
	RadiantPlayerPrintingErrorHandlingStandard = 'lwst' /* Standard PostScript error handling */,
	RadiantPlayerPrintingErrorHandlingDetailed = 'lwdt' /* print a detailed report of PostScript errors */
};
typedef enum RadiantPlayerPrintingErrorHandling RadiantPlayerPrintingErrorHandling;

@protocol RadiantGenericMethods

- (void) closeSaving:(RadiantPlayerSaveOptions)saving savingIn:(NSURL *)savingIn;  // Close a document.
- (void) saveIn:(NSURL *)in_;  // Save a document.
- (void) printWithProperties:(NSDictionary *)withProperties printDialog:(BOOL)printDialog;  // Print a document.
- (void) delete;  // Delete an object.
- (void) duplicateTo:(SBObject *)to withProperties:(NSDictionary *)withProperties;  // Copy an object.
- (void) moveTo:(SBObject *)to;  // Move an object to a new location.

@end



/*
 * Standard Suite
 */

// The application's top-level scripting object.
@interface RadiantPlayerApplication : SBApplication

- (SBElementArray<RadiantPlayerDocument *> *) documents;
- (SBElementArray<RadiantPlayerWindow *> *) windows;

@property (copy, readonly) NSString *name;  // The name of the application.
@property (readonly) BOOL frontmost;  // Is this the active application?
@property (copy, readonly) NSString *version;  // The version number of the application.

- (id) open:(id)x;  // Open a document.
- (void) print:(id)x withProperties:(NSDictionary *)withProperties printDialog:(BOOL)printDialog;  // Print a document.
- (void) quitSaving:(RadiantPlayerSaveOptions)saving;  // Quit the application.
- (BOOL) exists:(id)x;  // Verify that an object exists.
- (void) backTrack;  // reposition to beginning of current track or go to previous track if already at start of current track
- (void) nextTrack;  // advance to the next track in the current playlist
- (void) playpause;  // toggle the playing/paused state of the current track
- (void) toggleThumbsUp;  // toggle thumbs up for current track
- (void) toggleThumbsDown;  // toggle thumbs down for current track
- (void) toggleShuffle;  // toggle shuffle on/off
- (void) toggleRepeatmode;  // toggle repeat mode
- (void) toggleVisualization;  // toggle visualization on/off

@end

// A document.
@interface RadiantPlayerDocument : SBObject <RadiantGenericMethods>

@property (copy, readonly) NSString *name;  // Its name.
@property (readonly) BOOL modified;  // Has it been modified since the last save?
@property (copy, readonly) NSURL *file;  // Its location on disk, if it has one.


@end

// A window.
@interface RadiantPlayerWindow : SBObject <RadiantGenericMethods>

@property (copy, readonly) NSString *name;  // The title of the window.
- (NSInteger) id;  // The unique identifier of the window.
@property NSInteger index;  // The index of the window, ordered front to back.
@property NSRect bounds;  // The bounding rectangle of the window.
@property (readonly) BOOL closeable;  // Does the window have a close button?
@property (readonly) BOOL miniaturizable;  // Does the window have a minimize button?
@property BOOL miniaturized;  // Is the window minimized right now?
@property (readonly) BOOL resizable;  // Can the window be resized?
@property BOOL visible;  // Is the window visible right now?
@property (readonly) BOOL zoomable;  // Does the window have a zoom button?
@property BOOL zoomed;  // Is the window zoomed right now?
@property (copy, readonly) RadiantPlayerDocument *document;  // The document whose contents are displayed in the window.


@end



/*
 * Radiant Player Suite
 */

// Radiant Player's application object
@interface RadiantPlayerApplication (RadiantPlayerSuite)

@property (copy) NSString *currentSongName;  // name of the currently playing song
@property (copy) NSString *currentSongArtist;  // artist of the currently playing song
@property (copy) NSString *currentSongAlbum;  // album of the currently playing song
@property (copy) NSImage *currentSongArt;  // art image of the currently playing song
@property (copy) NSString *currentSongUrl;  // shareable URL of the currently playing song
@property NSInteger playerState;  // the state of the player (0 = stopped, 1 = paused, or 2 = playing)

@end


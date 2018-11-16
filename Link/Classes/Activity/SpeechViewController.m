//
//  SpeechViewController.m
//  Link
//
//  Created by Surdot on 2018/4/25.
//  Copyright © 2018年 Surdot. All rights reserved.
//

#import "SpeechViewController.h"
#import <Speech/Speech.h>
#import <AVFoundation/AVFoundation.h>

#define LoadingText @"正在录音。。。"
@interface SpeechViewController ()<SFSpeechRecognizerDelegate>
@property (nonatomic, strong) SFSpeechRecognizer *speechRecognizer;
@property (nonatomic, strong) AVAudioEngine *audioEngine;
@property (nonatomic, strong) SFSpeechRecognitionTask *recognitionTask;
@property (nonatomic, strong) SFSpeechAudioBufferRecognitionRequest *recognitionRequest;
@property (nonatomic, strong) AVAudioInputNode *bufferInputNode;
@property (nonatomic, strong) UILabel *textLb;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation SpeechViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.frame = CGRectMake(150, 150, 50, 50);
    [self.view addSubview:button];
    [button addTarget:self action:@selector(isPrepareRecording) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeContactAdd];
    buttonTwo.frame = CGRectMake(150, 210, 50, 50);
    [self.view addSubview:buttonTwo];
    [buttonTwo addTarget:self action:@selector(recognizeLocalAudio) forControlEvents:UIControlEventTouchUpInside];
    
    self.textLb = [[UILabel alloc] init];
    _textLb.backgroundColor = [UIColor yellowColor];
    _textLb.frame = CGRectMake(10, 100, [UIScreen mainScreen].bounds.size.width, 45);
    [self.view addSubview:_textLb];
    self.textLb.text = @"你想进行语音识别吗";
    
//    [self makeSpeechRecognizer];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        [self recognizeLocalAudio];
        [self isPrepareRecording];
    }];
    
    [self audioEngine];
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [self.timer invalidate];
    self.timer = nil;
}
- (void)recognizeLocalAudio {
    NSLocale *local = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    SFSpeechRecognizer *localRecognizer = [[SFSpeechRecognizer alloc] initWithLocale:local];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"录音.m4a" withExtension:nil];
    NSLog(@"语音url: %@", url);
    if (!url) {
        return;
    }
    SFSpeechURLRecognitionRequest *request = [[SFSpeechURLRecognitionRequest alloc] initWithURL:url];
//    __weak typeof (self) weakSelf = self;
    [localRecognizer recognitionTaskWithRequest:request resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        if (error) {
            NSLog(@"语音识别解析失败,%@", error);
        }else {
            self.textLb.text = result.bestTranscription.formattedString;
        }
    }];
}

- (void)makeSpeechRecognizer {
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (status) {
                case SFSpeechRecognizerAuthorizationStatusNotDetermined:
                    NSLog(@"语音识别未授权");
                    break;
                case SFSpeechRecognizerAuthorizationStatusDenied:
                    NSLog(@"用户未授权使用语音识别");
                    break;
                case SFSpeechRecognizerAuthorizationStatusRestricted:
                    NSLog(@"语音识别在这台设备上受到限制");
                    break;
                case SFSpeechRecognizerAuthorizationStatusAuthorized:
                    NSLog(@"开始录音啦");
                    break;
                default:
                    break;
            }
        });
    }];
}

#pragma mark - property
- (AVAudioEngine *)audioEngine{
    if (!_audioEngine) {
        _audioEngine = [[AVAudioEngine alloc] init];
    }
    return _audioEngine;
}
- (SFSpeechRecognizer *)speechRecognizer {
    if (!_speechRecognizer) {
        //要为语音识别对象设置语言，这里设置的是中文
        NSLocale *local =[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        
        _speechRecognizer =[[SFSpeechRecognizer alloc] initWithLocale:local];
        _speechRecognizer.delegate = self;
    }
    return _speechRecognizer;
}

- (void)isPrepareRecording {
    if (self.audioEngine.isRunning) {
        [self endRecording];
    }
    else{
        [self startRecording];
        
    }
}

- (void)startRecording{
    if (_recognitionTask) {
        [_recognitionTask cancel];
        _recognitionTask = nil;
    }
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *error;
    [audioSession setCategory:AVAudioSessionCategoryRecord error:&error];
    NSParameterAssert(!error);
    [audioSession setMode:AVAudioSessionModeMeasurement error:&error];
    NSParameterAssert(!error);
    [audioSession setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&error];
    NSParameterAssert(!error);
    
    _recognitionRequest = [[SFSpeechAudioBufferRecognitionRequest alloc] init];
    _recognitionRequest.shouldReportPartialResults = YES;
    self.bufferInputNode = [self.audioEngine inputNode];
    //    AVAudioInputNode *inputNode = self.audioEngine.inputNode;
    //    NSAssert(inputNode, @"录入设备没有准备好");
    //    NSAssert(_recognitionRequest, @"请求初始化失败");
    
    
    
    __weak typeof(self) weakSelf = self;
    _recognitionTask = [self.speechRecognizer recognitionTaskWithRequest:_recognitionRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        //        __strong typeof(weakSelf) strongSelf = weakSelf;
        BOOL isFinal = NO;
        if (result) {
            weakSelf.textLb.text = result.bestTranscription.formattedString;
            isFinal = result.isFinal;
        }
        if (error || isFinal) {
            [self.audioEngine stop];
            //            [inputNode removeTapOnBus:0];
            weakSelf.recognitionTask = nil;
            weakSelf.recognitionRequest = nil;
            //            strongSelf.recordButton.enabled = YES;
            //            [strongSelf.recordButton setTitle:@"开始录音" forState:UIControlStateNormal];
            weakSelf.textLb.text = @"录音失败";
        }
        
    }];
    //
    AVAudioFormat *recordingFormat = [self.bufferInputNode outputFormatForBus:0];
    [self.bufferInputNode installTapOnBus:0 bufferSize:1024 format:recordingFormat block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
        [weakSelf.recognitionRequest appendAudioPCMBuffer:buffer];
    }];
    //    //在添加tap之前先移除上一个  不然有可能报"Terminating app due to uncaught exception 'com.apple.coreaudio.avfaudio',"之类的错误
    //    [inputNode removeTapOnBus:0];
    //    [inputNode installTapOnBus:0 bufferSize:1024 format:recordingFormat block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
    //        __strong typeof(weakSelf) strongSelf = weakSelf;
    //        if (strongSelf.recognitionRequest) {
    //            [strongSelf.recognitionRequest appendAudioPCMBuffer:buffer];
    //        }
    //    }];
    //
    [self.audioEngine prepare];
    NSError *Error = nil;
    if (![self.audioEngine startAndReturnError:&Error]) {
        NSLog(@"%@", error.userInfo);
    }
    
    
    //    [self.audioEngine startAndReturnError:&error];
    //    NSParameterAssert(!error);
    
    
    self.textLb.text = LoadingText;
    NSLog(@"开始录音");
}
- (void)endRecording{
    [self.audioEngine stop];
    if (_recognitionRequest) {
        [_recognitionRequest endAudio];
    }
    
    if (_recognitionTask) {
        [_recognitionTask cancel];
        _recognitionTask = nil;
    }
    
    if ([self.textLb.text isEqualToString:LoadingText]) {
        self.textLb.text = @"";
    }
}

#pragma mark - SFSpeechRecognizerDelegate
- (void)speechRecognizer:(SFSpeechRecognizer *)speechRecognizer availabilityDidChange:(BOOL)available {
    if (available) {
        NSLog(@"正在开始录音");
    }
}

/**
 if (_recognitionTask) {
 [_recognitionTask cancel];
 _recognitionTask = nil;
 }
 
 AVAudioSession *audioSession = [AVAudioSession sharedInstance];
 NSError *error;
 [audioSession setCategory:AVAudioSessionCategoryRecord error:&error];
 NSParameterAssert(!error);
 [audioSession setMode:AVAudioSessionModeMeasurement error:&error];
 NSParameterAssert(!error);
 [audioSession setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&error];
 NSParameterAssert(!error);
 
 _recognitionRequest = [[SFSpeechAudioBufferRecognitionRequest alloc] init];
 _recognitionRequest.shouldReportPartialResults = YES;
 self.bufferInputNode = [self.audioEngine inputNode];
 //    AVAudioInputNode *inputNode = self.audioEngine.inputNode;
 //    NSAssert(inputNode, @"录入设备没有准备好");
 //    NSAssert(_recognitionRequest, @"请求初始化失败");
 
 
 
 __weak typeof(self) weakSelf = self;
 _recognitionTask = [self.speechRecognizer recognitionTaskWithRequest:_recognitionRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
 //        __strong typeof(weakSelf) strongSelf = weakSelf;
 BOOL isFinal = NO;
 if (result) {
 weakSelf.textLb.text = result.bestTranscription.formattedString;
 isFinal = result.isFinal;
 }
 if (error || isFinal) {
 [self.audioEngine stop];
 //            [inputNode removeTapOnBus:0];
 weakSelf.recognitionTask = nil;
 weakSelf.recognitionRequest = nil;
 //            strongSelf.recordButton.enabled = YES;
 //            [strongSelf.recordButton setTitle:@"开始录音" forState:UIControlStateNormal];
 weakSelf.textLb.text = @"录音失败";
 }
 
 }];
 //
 AVAudioFormat *recordingFormat = [self.bufferInputNode outputFormatForBus:0];
 [self.bufferInputNode installTapOnBus:0 bufferSize:1024 format:recordingFormat block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
 [weakSelf.recognitionRequest appendAudioPCMBuffer:buffer];
 }];
 //    //在添加tap之前先移除上一个  不然有可能报"Terminating app due to uncaught exception 'com.apple.coreaudio.avfaudio',"之类的错误
 //    [inputNode removeTapOnBus:0];
 //    [inputNode installTapOnBus:0 bufferSize:1024 format:recordingFormat block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
 //        __strong typeof(weakSelf) strongSelf = weakSelf;
 //        if (strongSelf.recognitionRequest) {
 //            [strongSelf.recognitionRequest appendAudioPCMBuffer:buffer];
 //        }
 //    }];
 //
 [self.audioEngine prepare];
 NSError *Error = nil;
 if (![self.audioEngine startAndReturnError:&Error]) {
 NSLog(@"%@", error.userInfo);
 }
 
 
 //    [self.audioEngine startAndReturnError:&error];
 //    NSParameterAssert(!error);
 
 
 self.textLb.text = LoadingText;
 NSLog(@"开始录音");
 */


@end

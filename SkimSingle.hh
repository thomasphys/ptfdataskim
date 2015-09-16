#ifndef SkimSingle_H
#define SkimSingle_H

#include "TRootanaEventLoop.hxx"
#include "TTree.h"
#include "TFile.h"
#include "TH1F.h"
#include "TH2F.h"
#include "TDataContainer.hxx"
#include "TV1730RawData.hxx"
//#include "ptfEvent.hh"
#include "PTFDict.h"
using namespace PTF;

class SkimSingle: public TRootanaEventLoop {

	public:
  	SkimSingle();
    virtual ~SkimSingle();
  	void Initialize();
  	void BeginRun(int transition,int run,int time);
    void EndRun(int transition,int run,int time);
  	bool ProcessMidasEvent(TDataContainer& dataContainer);
    bool CheckOption(std::string option);

    TH1F *ChargeHist;
    TH1F *BaselineHist;
    TH1F *TimeHist;
    TH1F *PeakHist;
    TH2F *Charge_Time;
    TH2F *Peak_Time;
    TH1F *SampleWave;
    int counter;
    bool savesamples;

    protected:
    PTF::ptfEvent *rootevent;
    TTree *tree;
}; 

#endif

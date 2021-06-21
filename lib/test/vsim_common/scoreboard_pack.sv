`ifndef SCOREBOARD__SV
`define SCOREBOARD__SV

`include "ethpack.sv"
`include "config.sv"

class Expect_packets;
    Ethpack p[$];
    int iexpect, iactual;
endclass

class Scoreboard;
    Config cfg;
    Expect_packets expect_packets[];
    int iexpect, iactual;
    string  id = "";

    extern function new(Config cfg, string id);
    extern virtual function void wrap_up();
    extern function void save_expected(Ethpack pack);
    extern function void check_actual(input Ethpack pack);
    extern function void display(string prefix="");
endclass

function Scoreboard::new(Config cfg, string id);
    this.cfg = cfg;
    this.id  = id;
    this.expect_packets = new[1];
    foreach (this.expect_packets[i]) begin
        this.expect_packets[i] = new();
    end
endfunction 

function void Scoreboard::save_expected(Ethpack pack);
    pack.display_pack($sformatf("@%0t: Scb_%s save: ", $time, id));
    this.expect_packets[0].p.push_back(pack); // Save packet in forward queue
    this.expect_packets[0].iexpect++;
    //foreach (this.expect_packets[0].p[i]) begin
    //    $display("@%0t: all exist %x", $time, this.expect_packets[0].p[i].crc);
    //end
endfunction

function void Scoreboard::check_actual(input Ethpack pack);

    pack.display_pack($sformatf("@%0t: Scb_%s check: ", $time, id));

    if (pack.crc_ok != 1) begin
        $display("@%0t: Scb_%s: ERROR: receive CRC packet", $time, id);
        cfg.nErrors++;
        return;
    end

    if (this.expect_packets[0].p.size() == 0) begin
        $display("@%0t: Scb_%s: ERROR:  pack not found because scoreboard for TX empty", $time, id);
        pack.display_pack("Not Found: ");
        cfg.nErrors++;
        return;
    end

    this.expect_packets[0].iactual++;

    foreach (this.expect_packets[0].p[i]) begin
        if (this.expect_packets[0].p[i].compare(pack)) begin
            $display("@%0t: Scb_%s: Match found for packet", $time, id);
            this.expect_packets[0].p.delete(i);
            return;
        end
    end

    $display("@%0t: Scb_%s: ERROR: packet not found", $time, id);
    pack.display_pack("Not Found: ");
    cfg.nErrors++;
endfunction

function void Scoreboard::wrap_up();
    $display("@%0t: Scb_%s: %0d expected packets, %0d actual packets received", $time, id, this.expect_packets[0].iexpect, this.expect_packets[0].iactual);

    if (this.expect_packets[0].p.size()) begin
        $display("@%0t: Scb_%s: packets remaining in Tx scoreboard at end of test", $time, id);
        this.display("Unclaimed: ");
        cfg.nErrors++;
    end
endfunction

function void Scoreboard::display(string prefix="");
    foreach (this.expect_packets[0].p[j]) begin
        this.expect_packets[0].p[j].display_pack($sformatf("@%0t: %sScb_%s: ", $time, prefix, id));
    end
endfunction

`endif




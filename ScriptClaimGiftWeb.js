(async () => {
  const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

  const CHECK_INTERVAL_MS = 1500;

  // Hàm hỗ trợ tìm và bấm nút đóng Popup ngay khi nó xuất hiện
  const closePopupIfPresent = async (maxWaitMs = 1000) => {
    const start = Date.now();

    while (Date.now() - start < maxWaitMs) {
      const closeBtn = document.querySelector(".e3-popup-close");

      if (closeBtn) {
        closeBtn.click();

        console.log("[Auto-Claim] Đã tự động đóng Popup phần thưởng!");

        return true;
      }

      await sleep(50); // Kiểm tra lại mỗi 50ms
    }

    return false;
  };

  console.log("[Auto-Monitor] Bắt đầu vòng lặp theo dõi nhiệm vụ...");

  while (true) {
    // 1. Quét các nhiệm vụ đã hoàn thành nhưng chưa nhận thưởng

    const unclaimedMissions = document.querySelectorAll(
      '[class*="--completedUnclaimed"]',
    );

    if (unclaimedMissions.length > 0) {
      console.log(
        `[Auto-Claim] Tìm thấy ${unclaimedMissions.length} nhiệm vụ ready! Đang bấm nhận...`,
      );

      for (let i = 0; i < unclaimedMissions.length; i++) {
        const mission = unclaimedMissions[i];

        const button = mission.querySelector(
          '[class*="-mission-action"], .e3-game-button',
        );

        if (button) {
          button.click();

          const missionTitle =
            mission.querySelector("h3")?.innerText || `Nhiệm vụ #${i + 1}`;

          console.log(`[Auto-Claim] Đã nhận: "${missionTitle}"`);

          // Tự động tìm và đóng popup trong tối đa 1 giây

          await closePopupIfPresent(1000);

          await sleep(200); // Tạm dừng ngắn để ổn định giao diện
        }
      }
    }

    // 2. Kiểm tra xem còn nhiệm vụ nào chưa hoàn thành (notStarted) không

    const notStartedMissions = document.querySelectorAll(
      '[class*="--notStarted"]',
    );

    if (notStartedMissions.length === 0 && unclaimedMissions.length === 0) {
      console.log("[Auto-Monitor] Tất cả nhiệm vụ đã hoàn tất và nhận xong!");

      break;
    }

    console.log(
      `[Auto-Monitor] Còn ${notStartedMissions.length} nhiệm vụ đang chờ. Thử lại sau ${CHECK_INTERVAL_MS / 1000}s...`,
    );

    await sleep(CHECK_INTERVAL_MS);
  }
})();
